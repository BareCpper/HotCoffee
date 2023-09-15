#pragma once

constexpr bool floatNear( float a, float b, float epsilon )
{
    return std::abs(a-b) <= epsilon;
}