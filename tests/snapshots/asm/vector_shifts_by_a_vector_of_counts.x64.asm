
vector_shifts_by_a_vector_of_counts.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<shifts_s8x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	leaq	-0x10(%rbp), %rax
               	vpextrb	$0x0, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x0, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x10(%rbp)
               	vpextrb	$0x1, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x1, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xf(%rbp)
               	vpextrb	$0x2, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x2, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xe(%rbp)
               	vpextrb	$0x3, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x3, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xd(%rbp)
               	vpextrb	$0x4, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x4, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xc(%rbp)
               	vpextrb	$0x5, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x5, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xb(%rbp)
               	vpextrb	$0x6, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x6, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xa(%rbp)
               	vpextrb	$0x7, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x7, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x9(%rbp)
               	vpextrb	$0x8, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x8, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x8(%rbp)
               	vpextrb	$0x9, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0x9, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x7(%rbp)
               	vpextrb	$0xa, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xa, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x6(%rbp)
               	vpextrb	$0xb, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xb, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x5(%rbp)
               	vpextrb	$0xc, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xc, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x4(%rbp)
               	vpextrb	$0xd, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xd, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x3(%rbp)
               	vpextrb	$0xe, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xe, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x2(%rbp)
               	vpextrb	$0xf, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	vpextrb	$0xf, %xmm1, %edx
               	movsbq	%dl, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x1(%rbp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x10(%rdi), %rax
               	leaq	-0x10(%rbp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x0, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x10(%rbp)
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x1, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xf(%rbp)
               	vpextrb	$0x2, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x2, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xe(%rbp)
               	vpextrb	$0x3, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x3, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xd(%rbp)
               	vpextrb	$0x4, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x4, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xc(%rbp)
               	vpextrb	$0x5, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x5, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xb(%rbp)
               	vpextrb	$0x6, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x6, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xa(%rbp)
               	vpextrb	$0x7, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x7, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x9(%rbp)
               	vpextrb	$0x8, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x8, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x8(%rbp)
               	vpextrb	$0x9, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0x9, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x7(%rbp)
               	vpextrb	$0xa, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xa, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x6(%rbp)
               	vpextrb	$0xb, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xb, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x5(%rbp)
               	vpextrb	$0xc, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xc, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x4(%rbp)
               	vpextrb	$0xd, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xd, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x3(%rbp)
               	vpextrb	$0xe, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xe, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x2(%rbp)
               	vpextrb	$0xf, %xmm0, %edx
               	movsbq	%dl, %rdx
               	vpextrb	$0xf, %xmm1, %esi
               	movsbq	%sil, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x1(%rbp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leave
               	retq

<check_s8x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x40(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x30(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x3f(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2f(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x3e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x3d(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2d(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x3c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x3b(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2b(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x3a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x39(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x29(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x28(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x37(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x27(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x36(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x26(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x35(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x25(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x34(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x24(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x33(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x23(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x32(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x22(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movb	%al, -0x31(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x21(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movsbq	-0x40(%rbp,%rax), %rcx
               	movsbq	-0x30(%rbp,%rax), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	movsbq	%sil, %rsi
               	sarxq	%rdx, %rcx, %rcx
               	movsbq	%cl, %rdx
               	leaq	-0x20(%rbp), %rcx
               	movsbq	-0x20(%rbp,%rax), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x10, %rcx
               	movsbq	(%rcx,%rax), %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq

<shifts_u8x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	leaq	-0x10(%rbp), %rax
               	vpextrb	$0x0, %xmm0, %ecx
               	vpextrb	$0x0, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x10(%rbp)
               	vpextrb	$0x1, %xmm0, %ecx
               	vpextrb	$0x1, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xf(%rbp)
               	vpextrb	$0x2, %xmm0, %ecx
               	vpextrb	$0x2, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xe(%rbp)
               	vpextrb	$0x3, %xmm0, %ecx
               	vpextrb	$0x3, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xd(%rbp)
               	vpextrb	$0x4, %xmm0, %ecx
               	vpextrb	$0x4, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xc(%rbp)
               	vpextrb	$0x5, %xmm0, %ecx
               	vpextrb	$0x5, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xb(%rbp)
               	vpextrb	$0x6, %xmm0, %ecx
               	vpextrb	$0x6, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0xa(%rbp)
               	vpextrb	$0x7, %xmm0, %ecx
               	vpextrb	$0x7, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x9(%rbp)
               	vpextrb	$0x8, %xmm0, %ecx
               	vpextrb	$0x8, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x8(%rbp)
               	vpextrb	$0x9, %xmm0, %ecx
               	vpextrb	$0x9, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x7(%rbp)
               	vpextrb	$0xa, %xmm0, %ecx
               	vpextrb	$0xa, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x6(%rbp)
               	vpextrb	$0xb, %xmm0, %ecx
               	vpextrb	$0xb, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x5(%rbp)
               	vpextrb	$0xc, %xmm0, %ecx
               	vpextrb	$0xc, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x4(%rbp)
               	vpextrb	$0xd, %xmm0, %ecx
               	vpextrb	$0xd, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x3(%rbp)
               	vpextrb	$0xe, %xmm0, %ecx
               	vpextrb	$0xe, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x2(%rbp)
               	vpextrb	$0xf, %xmm0, %ecx
               	vpextrb	$0xf, %xmm1, %edx
               	shlxq	%rdx, %rcx, %rcx
               	movb	%cl, -0x1(%rbp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x10(%rdi), %rax
               	leaq	-0x10(%rbp), %rcx
               	vpextrb	$0x0, %xmm0, %edx
               	vpextrb	$0x0, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x10(%rbp)
               	vpextrb	$0x1, %xmm0, %edx
               	vpextrb	$0x1, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xf(%rbp)
               	vpextrb	$0x2, %xmm0, %edx
               	vpextrb	$0x2, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xe(%rbp)
               	vpextrb	$0x3, %xmm0, %edx
               	vpextrb	$0x3, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xd(%rbp)
               	vpextrb	$0x4, %xmm0, %edx
               	vpextrb	$0x4, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xc(%rbp)
               	vpextrb	$0x5, %xmm0, %edx
               	vpextrb	$0x5, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xb(%rbp)
               	vpextrb	$0x6, %xmm0, %edx
               	vpextrb	$0x6, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0xa(%rbp)
               	vpextrb	$0x7, %xmm0, %edx
               	vpextrb	$0x7, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x9(%rbp)
               	vpextrb	$0x8, %xmm0, %edx
               	vpextrb	$0x8, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x8(%rbp)
               	vpextrb	$0x9, %xmm0, %edx
               	vpextrb	$0x9, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x7(%rbp)
               	vpextrb	$0xa, %xmm0, %edx
               	vpextrb	$0xa, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x6(%rbp)
               	vpextrb	$0xb, %xmm0, %edx
               	vpextrb	$0xb, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x5(%rbp)
               	vpextrb	$0xc, %xmm0, %edx
               	vpextrb	$0xc, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x4(%rbp)
               	vpextrb	$0xd, %xmm0, %edx
               	vpextrb	$0xd, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x3(%rbp)
               	vpextrb	$0xe, %xmm0, %edx
               	vpextrb	$0xe, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x2(%rbp)
               	vpextrb	$0xf, %xmm0, %edx
               	vpextrb	$0xf, %xmm1, %esi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, -0x1(%rbp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leave
               	retq

<check_u8x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x40(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x30(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x3f(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2f(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x3e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x3d(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2d(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x3c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x3b(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2b(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x3a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x2a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x39(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x29(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x28(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x37(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x27(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x36(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x26(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x35(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x25(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x34(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x24(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x33(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x23(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x32(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x22(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xff, %rax
               	movb	%al, -0x31(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x7, %rax
               	movb	%al, -0x21(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x40(%rbp,%rax), %rcx
               	movzbq	-0x30(%rbp,%rax), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	andq	$0xff, %rsi
               	shrxq	%rdx, %rcx, %rcx
               	movq	%rcx, %rdx
               	andq	$0xff, %rdx
               	leaq	-0x20(%rbp), %rcx
               	movzbq	-0x20(%rbp,%rax), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x10, %rcx
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq

<shifts_s16x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	leaq	-0x10(%rbp), %rax
               	vpextrw	$0x0, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x0, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0x10(%rbp)
               	vpextrw	$0x1, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x1, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0xe(%rbp)
               	vpextrw	$0x2, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x2, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0xc(%rbp)
               	vpextrw	$0x3, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x3, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0xa(%rbp)
               	vpextrw	$0x4, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x4, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0x8(%rbp)
               	vpextrw	$0x5, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x5, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0x6(%rbp)
               	vpextrw	$0x6, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x6, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0x4(%rbp)
               	vpextrw	$0x7, %xmm0, %ecx
               	movswq	%cx, %rcx
               	vpextrw	$0x7, %xmm1, %edx
               	movswq	%dx, %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, -0x2(%rbp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x10(%rdi), %rax
               	leaq	-0x10(%rbp), %rcx
               	vpextrw	$0x0, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x0, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0x10(%rbp)
               	vpextrw	$0x1, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x1, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0xe(%rbp)
               	vpextrw	$0x2, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x2, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0xc(%rbp)
               	vpextrw	$0x3, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x3, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0xa(%rbp)
               	vpextrw	$0x4, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x4, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0x8(%rbp)
               	vpextrw	$0x5, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x5, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0x6(%rbp)
               	vpextrw	$0x6, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x6, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0x4(%rbp)
               	vpextrw	$0x7, %xmm0, %edx
               	movswq	%dx, %rdx
               	vpextrw	$0x7, %xmm1, %esi
               	movswq	%si, %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0x2(%rbp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leave
               	retq

<check_s16x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x40(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x30(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x3e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x2e(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x3c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x2c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x3a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x2a(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x38(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x28(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x36(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x26(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x34(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x24(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movw	%ax, -0x32(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, -0x22(%rbp)
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movswq	-0x40(%rbp,%rax,2), %rcx
               	movswq	-0x30(%rbp,%rax,2), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	movswq	%si, %rsi
               	sarxq	%rdx, %rcx, %rcx
               	movswq	%cx, %rdx
               	leaq	-0x20(%rbp), %rcx
               	movswq	-0x20(%rbp,%rax,2), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x10, %rcx
               	movswq	(%rcx,%rax,2), %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq

<shifts_u16x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x40(%rsp), %rax
               	movzwq	(%rsp), %rcx
               	movzwq	0x20(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x40(%rsp)
               	movzwq	0x2(%rsp), %rcx
               	movzwq	0x22(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x42(%rsp)
               	movzwq	0x4(%rsp), %rcx
               	movzwq	0x24(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x44(%rsp)
               	movzwq	0x6(%rsp), %rcx
               	movzwq	0x26(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x46(%rsp)
               	movzwq	0x8(%rsp), %rcx
               	movzwq	0x28(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x48(%rsp)
               	movzwq	0xa(%rsp), %rcx
               	movzwq	0x2a(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x4a(%rsp)
               	movzwq	0xc(%rsp), %rcx
               	movzwq	0x2c(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x4c(%rsp)
               	movzwq	0xe(%rsp), %rcx
               	movzwq	0x2e(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x4e(%rsp)
               	movzwq	0x10(%rsp), %rcx
               	movzwq	0x30(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x50(%rsp)
               	movzwq	0x12(%rsp), %rcx
               	movzwq	0x32(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x52(%rsp)
               	movzwq	0x14(%rsp), %rcx
               	movzwq	0x34(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x54(%rsp)
               	movzwq	0x16(%rsp), %rcx
               	movzwq	0x36(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x56(%rsp)
               	movzwq	0x18(%rsp), %rcx
               	movzwq	0x38(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x58(%rsp)
               	movzwq	0x1a(%rsp), %rcx
               	movzwq	0x3a(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x5a(%rsp)
               	movzwq	0x1c(%rsp), %rcx
               	movzwq	0x3c(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x5c(%rsp)
               	movzwq	0x1e(%rsp), %rcx
               	movzwq	0x3e(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movw	%cx, 0x5e(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x20(%rdi), %rax
               	leaq	0x40(%rsp), %rcx
               	movzwq	(%rsp), %rdx
               	movzwq	0x20(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x40(%rsp)
               	movzwq	0x2(%rsp), %rdx
               	movzwq	0x22(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x42(%rsp)
               	movzwq	0x4(%rsp), %rdx
               	movzwq	0x24(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x44(%rsp)
               	movzwq	0x6(%rsp), %rdx
               	movzwq	0x26(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x46(%rsp)
               	movzwq	0x8(%rsp), %rdx
               	movzwq	0x28(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x48(%rsp)
               	movzwq	0xa(%rsp), %rdx
               	movzwq	0x2a(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x4a(%rsp)
               	movzwq	0xc(%rsp), %rdx
               	movzwq	0x2c(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x4c(%rsp)
               	movzwq	0xe(%rsp), %rdx
               	movzwq	0x2e(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x4e(%rsp)
               	movzwq	0x10(%rsp), %rdx
               	movzwq	0x30(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x50(%rsp)
               	movzwq	0x12(%rsp), %rdx
               	movzwq	0x32(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x52(%rsp)
               	movzwq	0x14(%rsp), %rdx
               	movzwq	0x34(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x54(%rsp)
               	movzwq	0x16(%rsp), %rdx
               	movzwq	0x36(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x56(%rsp)
               	movzwq	0x18(%rsp), %rdx
               	movzwq	0x38(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x58(%rsp)
               	movzwq	0x1a(%rsp), %rdx
               	movzwq	0x3a(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x5a(%rsp)
               	movzwq	0x1c(%rsp), %rdx
               	movzwq	0x3c(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x5c(%rsp)
               	movzwq	0x1e(%rsp), %rdx
               	movzwq	0x3e(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movw	%dx, 0x5e(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<check_u16x16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x2(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x22(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x6(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x26(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0xa(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0xe(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x2e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x12(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x32(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x16(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x36(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x1a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x3a(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x3c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x1e(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0xf, %rax
               	movw	%ax, 0x3e(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movzwq	(%rsp,%rax,2), %rcx
               	movzwq	0x20(%rsp,%rax,2), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	shrxq	%rdx, %rcx, %rcx
               	movq	%rcx, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	leaq	0x40(%rsp), %rcx
               	movzwq	0x40(%rsp,%rax,2), %rdi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x20, %rcx
               	movzwq	(%rcx,%rax,2), %rcx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<shifts_s32x8>:
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpsllvd	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsravd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x20(%rdi)
               	vzeroupper
               	retq

<check_s32x8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x4(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x24(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0xc(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x2c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x14(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x34(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x38(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movl	%eax, 0x1c(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, 0x3c(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	movslq	(%rsp,%rax,4), %rcx
               	movslq	0x20(%rsp,%rax,4), %rdx
               	shlxq	%rdx, %rcx, %rsi
               	sarxq	%rdx, %rcx, %rdx
               	leaq	0x40(%rsp), %rcx
               	movl	0x40(%rsp,%rax,4), %edi
               	cmpl	%esi, %edi
               	jne	<addr>
               	addq	$0x20, %rcx
               	movl	(%rcx,%rax,4), %ecx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<shifts_u32x4>:
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	vpsllvd	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, (%rdi)
               	vpsrlvd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x10(%rdi)
               	retq

<check_u32x4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r12 # imm = 0x14057B7EF767814F
               	addq	%rax, %r12
               	movq	%r12, <rip> # <addr>
               	shrq	$0xb, %r12
               	movl	%r12d, -0x60(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r13
               	andq	$0x1f, %r13
               	movl	%r13d, -0x50(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r14 # imm = 0x14057B7EF767814F
               	addq	%rax, %r14
               	movq	%r14, <rip> # <addr>
               	shrq	$0xb, %r14
               	movl	%r14d, -0x5c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r15
               	andq	$0x1f, %r15
               	movl	%r15d, -0x4c(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movl	%ecx, -0x58(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r8
               	andq	$0x1f, %r8
               	movl	%r8d, -0x48(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r9 # imm = 0x14057B7EF767814F
               	addq	%rax, %r9
               	movq	%r9, <rip> # <addr>
               	shrq	$0xb, %r9
               	movl	%r9d, -0x54(%rbp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x1f, %rax
               	movl	%eax, -0x44(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x50(%rbp), %rdx
               	movq	%rcx, 0x88(%rsp)
               	movq	%r8, 0x80(%rsp)
               	movq	%r9, 0x78(%rsp)
               	movq	%rax, 0x70(%rsp)
               	callq	<addr>
               	movq	%rax, %rdx
               	movq	0x88(%rsp), %rcx
               	movq	0x80(%rsp), %r8
               	movq	0x78(%rsp), %r9
               	movq	0x70(%rsp), %rax
               	shlxq	%r13, %r12, %rdx
               	movl	%r12d, %esi
               	shrxq	%r13, %rsi, %rsi
               	movl	-0x40(%rbp), %edi
               	cmpl	%edx, %edi
               	jne	<addr>
               	movl	-0x30(%rbp), %edx
               	cmpl	%esi, %edx
               	jne	<addr>
               	shlxq	%r15, %r14, %rdx
               	movl	%r14d, %esi
               	shrxq	%r15, %rsi, %rsi
               	movl	-0x3c(%rbp), %edi
               	cmpl	%edx, %edi
               	jne	<addr>
               	movl	-0x2c(%rbp), %edx
               	cmpl	%esi, %edx
               	jne	<addr>
               	shlxq	%r8, %rcx, %rdx
               	movl	%ecx, %ecx
               	shrxq	%r8, %rcx, %rcx
               	movl	-0x38(%rbp), %esi
               	cmpl	%edx, %esi
               	jne	<addr>
               	movl	-0x28(%rbp), %edx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	shlxq	%rax, %r9, %rcx
               	movl	%r9d, %edx
               	shrxq	%rax, %rdx, %rax
               	movl	-0x34(%rbp), %edx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movl	-0x24(%rbp), %ecx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<shifts_s64x2>:
               	movups	(%rsi), %xmm0
               	movups	(%rdx), %xmm1
               	vpsllvq	%xmm1, %xmm0, %xmm2
               	movups	%xmm2, (%rdi)
               	vmovq	%xmm0, %rax
               	vmovq	%xmm1, %rcx
               	sarxq	%rcx, %rax, %rax
               	vpextrq	$0x1, %xmm0, %rcx
               	vpextrq	$0x1, %xmm1, %rdx
               	sarxq	%rdx, %rcx, %rcx
               	movq	%rax, 0x10(%rdi)
               	movq	%rcx, 0x18(%rdi)
               	retq

<check_s64x2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r13d, %r13d
               	movabsq	$0x14057b7ef767814f, %rbx # imm = 0x14057B7EF767814F
               	movabsq	$0x5851f42d4c957f2d, %r12 # imm = 0x5851F42D4C957F2D
               	movq	<rip>, %rax # <addr>
               	imulq	%r12, %rax
               	leaq	(%rax,%rbx), %r14
               	movq	%r14, <rip> # <addr>
               	shrq	$0xb, %r14
               	movq	%r14, -0x50(%rbp)
               	movq	<rip>, %rax # <addr>
               	imulq	%r12, %rax
               	addq	%rbx, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r15
               	andq	$0x3f, %r15
               	movq	%r15, -0x40(%rbp)
               	movq	<rip>, %rax # <addr>
               	imulq	%r12, %rax
               	leaq	(%rax,%rbx), %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, -0x48(%rbp)
               	movq	<rip>, %rax # <addr>
               	imulq	%r12, %rax
               	addq	%rbx, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r8
               	andq	$0x3f, %r8
               	movq	%r8, -0x38(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x40(%rbp), %rdx
               	movq	%rcx, 0x78(%rsp)
               	movq	%r8, 0x70(%rsp)
               	callq	<addr>
               	movq	0x78(%rsp), %rcx
               	movq	0x70(%rsp), %r8
               	shlxq	%r15, %r14, %rax
               	sarxq	%r15, %r14, %rdx
               	movq	-0x30(%rbp), %rsi
               	cmpq	%rax, %rsi
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	shlxq	%r8, %rcx, %rax
               	sarxq	%r8, %rcx, %rcx
               	movq	-0x28(%rbp), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	incq	%r13
               	cmpl	$0x14, %r13d
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<shifts_u64x4>:
               	vmovups	(%rsi), %ymm0
               	vmovups	(%rdx), %ymm1
               	vpsllvq	%ymm1, %ymm0, %ymm2
               	vmovups	%ymm2, (%rdi)
               	vpsrlvq	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x20(%rdi)
               	vzeroupper
               	retq

<check_u64x4>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r12 # imm = 0x14057B7EF767814F
               	addq	%rax, %r12
               	movq	%r12, <rip> # <addr>
               	shrq	$0xb, %r12
               	movq	%r12, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r13
               	andq	$0x3f, %r13
               	movq	%r13, 0x20(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r14 # imm = 0x14057B7EF767814F
               	addq	%rax, %r14
               	movq	%r14, <rip> # <addr>
               	shrq	$0xb, %r14
               	movq	%r14, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r15
               	andq	$0x3f, %r15
               	movq	%r15, 0x28(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %rcx # imm = 0x14057B7EF767814F
               	addq	%rax, %rcx
               	movq	%rcx, <rip> # <addr>
               	shrq	$0xb, %rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	movq	%rax, %r8
               	andq	$0x3f, %r8
               	movq	%r8, 0x30(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r9 # imm = 0x14057B7EF767814F
               	addq	%rax, %r9
               	movq	%r9, <rip> # <addr>
               	shrq	$0xb, %r9
               	movq	%r9, 0x18(%rsp)
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x5851f42d4c957f2d, %r11 # imm = 0x5851F42D4C957F2D
               	imulq	%r11, %rax
               	movabsq	$0x14057b7ef767814f, %r11 # imm = 0x14057B7EF767814F
               	addq	%r11, %rax
               	movq	%rax, <rip> # <addr>
               	shrq	$0xb, %rax
               	andq	$0x3f, %rax
               	movq	%rax, 0x38(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, -0x8(%rbp)
               	movq	%r8, -0x10(%rbp)
               	movq	%r9, -0x18(%rbp)
               	movq	%rax, -0x20(%rbp)
               	callq	<addr>
               	movq	%rax, %rdx
               	movq	-0x8(%rbp), %rcx
               	movq	-0x10(%rbp), %r8
               	movq	-0x18(%rbp), %r9
               	movq	-0x20(%rbp), %rax
               	shlxq	%r13, %r12, %rdx
               	shrxq	%r13, %r12, %rsi
               	movq	0x40(%rsp), %rdi
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movq	0x60(%rsp), %rdx
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	shlxq	%r15, %r14, %rdx
               	shrxq	%r15, %r14, %rsi
               	movq	0x48(%rsp), %rdi
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	movq	0x68(%rsp), %rdx
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	shlxq	%r8, %rcx, %rdx
               	shrxq	%r8, %rcx, %rcx
               	movq	0x50(%rsp), %rsi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movq	0x70(%rsp), %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	shlxq	%rax, %r9, %rcx
               	shrxq	%rax, %r9, %rax
               	movq	0x58(%rsp), %rdx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	0x78(%rsp), %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x10, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xf, %eax
               	leaq	-0x50(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
