// C99 6.4.6p3: `<:` `:>` `<%` `%>` `%:` `%:%:` behave as `[` `]` `{` `}`
// `#` `##` except for their spelling, which `#` keeps. Literals hold
// them as plain characters, and `<<=` and `%=` stay one token each.
// Returns 0.
%:define STR(x) %:x
%:define XSTR(x) STR(x)
%:define CAT(a, b) a %:%: b
#define GLUE(a, b) a ## b
%:if 1 < 2
int on = 1;
%:else
int on = 0;
%:endif
struct s <% int v<:2:>; %>;
static int cmp(const char *a, const char *b) <%
    while (*a && *a == *b)
        a++, b++;
    return *a != *b;
%>

int main(void) <%
    int a<:3:> = <% 1, 2, 3 %>;
    struct s t = <% <% 7, 8 %> %>;
    int CAT(x, y) = a<:1:> + t.v<:1:>;
    int e = 10, f = 3;
    if (!on || xy != 10 || sizeof a != 3 * sizeof(int))
        return 1;
    if (cmp(STR(<: :> <% %> %: %:%:), "<: :> <% %> %: %:%:") || cmp(XSTR(GLUE(<, :)), "<:"))
        return 2;
    if (cmp("<:%>", "<" ":" "%" ">") || '<' + 0 != 60 || ':' + 0 != 58)
        return 3;
    e <<= 1;
    e %= f;
    return e == 2 && a<:2:>%f == 0 ? 0 : 4;
%>
