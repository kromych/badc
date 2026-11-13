
packed_bitfield_bounds.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1e, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%edi, %edi
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	cmpq	$-0x1, %r12
               	je	<addr>
               	leaq	(%r12,%rbx), %rdi
               	xorl	%edx, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	(%r12,%rbx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x3(%rax), %rcx
               	leaq	-0x5(%rax), %r9
               	leaq	-0x6(%rax), %rbx
               	leaq	-0x7(%rax), %rdx
               	leaq	-0xe(%rax), %rdi
               	leaq	-0x9(%rax), %r8
               	leaq	-0x11(%rax), %rsi
               	leaq	-0x10(%rax), %r13
               	movb	$-0x1, (%r13)
               	movb	$-0x1, -0xf(%rax)
               	movw	$0xffff, -0xe(%rax)     # imm = 0xFFFF
               	movl	$0xffffffff, -0xc(%rax) # imm = 0xFFFFFFFF
               	movq	$-0x1, -0x8(%rax)
               	movzwq	(%rcx), %r12
               	movzbq	0x2(%rcx), %r13
               	shlq	$0x10, %r13
               	orq	%r13, %r12
               	andq	$-0x400000, %r12        # imm = 0xFFC00000
               	orq	$0x3ffffb, %r12         # imm = 0x3FFFFB
               	movw	%r12w, (%rcx)
               	shrq	$0x10, %r12
               	movb	%r12b, 0x2(%rcx)
               	movzwq	(%rcx), %r12
               	movzbq	0x2(%rcx), %r13
               	movq	%r13, %r14
               	shlq	$0x10, %r14
               	orq	%r12, %r14
               	shlq	$0x2a, %r14
               	sarq	$0x2a, %r14
               	addq	$0x7, %r14
               	andq	$0x3fffff, %r14         # imm = 0x3FFFFF
               	shlq	$0x10, %r13
               	orq	%r13, %r12
               	andq	$-0x400000, %r12        # imm = 0xFFC00000
               	orq	%r14, %r12
               	movw	%r12w, (%rcx)
               	shrq	$0x10, %r12
               	movb	%r12b, 0x2(%rcx)
               	movzwq	(%rcx), %r12
               	movzbq	0x2(%rcx), %r13
               	shlq	$0x10, %r13
               	orq	%r13, %r12
               	shlq	$0x2a, %r12
               	sarq	$0x2a, %r12
               	cmpl	$0x2, %r12d
               	jne	<addr>
               	movzbq	-0x1(%rax), %r12
               	cmpl	$0xc0, %r12d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %r13
               	movb	$-0x1, (%r13)
               	movb	$-0x1, -0xf(%rax)
               	movw	$0xffff, -0xe(%rax)     # imm = 0xFFFF
               	movl	$0xffffffff, -0xc(%rax) # imm = 0xFFFFFFFF
               	movq	$-0x1, -0x8(%rax)
               	movl	(%r9), %r12d
               	movzbq	0x4(%r9), %r13
               	shlq	$0x20, %r13
               	orq	%r13, %r12
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r12
               	movabsq	$0xedcba9877, %r11      # imm = 0xEDCBA9877
               	orq	%r11, %r12
               	movl	%r12d, (%r9)
               	shrq	$0x20, %r12
               	movb	%r12b, 0x4(%r9)
               	movl	(%r9), %r12d
               	movzbq	0x4(%r9), %r13
               	movq	%r13, %r14
               	shlq	$0x20, %r14
               	orq	%r12, %r14
               	shlq	$0x1c, %r14
               	sarq	$0x1c, %r14
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %r14
               	jne	<addr>
               	movzbq	-0x1(%rax), %r14
               	cmpl	$0xfe, %r14d
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	shlq	$0x20, %r13
               	orq	%r13, %r12
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r12
               	orq	$0x5, %r12
               	movl	%r12d, (%r9)
               	shrq	$0x20, %r12
               	movb	%r12b, 0x4(%r9)
               	movl	(%r9), %r12d
               	movzbq	0x4(%r9), %r9
               	shlq	$0x20, %r9
               	orq	%r12, %r9
               	shlq	$0x1c, %r9
               	sarq	$0x1c, %r9
               	cmpq	$0x5, %r9
               	jne	<addr>
               	movzbq	-0x1(%rax), %r9
               	cmpl	$0xf0, %r9d
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %r12
               	movb	$-0x1, (%r12)
               	movb	$-0x1, -0xf(%rax)
               	movw	$0xffff, -0xe(%rax)     # imm = 0xFFFF
               	movl	$0xffffffff, -0xc(%rax) # imm = 0xFFFFFFFF
               	movq	$-0x1, -0x8(%rax)
               	movl	(%rbx), %r9d
               	movzwq	0x4(%rbx), %r12
               	shlq	$0x20, %r12
               	orq	%r12, %r9
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %r9
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	orq	%r11, %r9
               	movl	%r9d, (%rbx)
               	shrq	$0x20, %r9
               	movw	%r9w, 0x4(%rbx)
               	movl	(%rbx), %r9d
               	movzwq	0x4(%rbx), %r12
               	movq	%r12, %r13
               	shlq	$0x20, %r13
               	orq	%r9, %r13
               	shlq	$0x14, %r13
               	sarq	$0x14, %r13
               	decq	%r13
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %r13
               	shlq	$0x20, %r12
               	orq	%r12, %r9
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %r9
               	orq	%r13, %r9
               	movl	%r9d, (%rbx)
               	shrq	$0x20, %r9
               	movw	%r9w, 0x4(%rbx)
               	movl	(%rbx), %r9d
               	movzwq	0x4(%rbx), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	shlq	$0x14, %r9
               	sarq	$0x14, %r9
               	movabsq	$0x7fffffffffe, %r11    # imm = 0x7FFFFFFFFFE
               	cmpq	%r11, %r9
               	jne	<addr>
               	movzbq	-0x1(%rax), %r9
               	cmpl	$0xf7, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %rbx
               	movb	$-0x1, (%rbx)
               	movb	$-0x1, -0xf(%rax)
               	movw	$0xffff, -0xe(%rax)     # imm = 0xFFFF
               	movl	$0xffffffff, -0xc(%rax) # imm = 0xFFFFFFFF
               	movq	$-0x1, -0x8(%rax)
               	movl	(%rdx), %r9d
               	movzwq	0x4(%rdx), %r12
               	shlq	$0x20, %r12
               	orq	%r12, %r9
               	movzbq	0x6(%rdx), %r12
               	shlq	$0x30, %r12
               	orq	%r12, %r9
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %r9
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	orq	%r11, %r9
               	movl	%r9d, (%rdx)
               	movq	%r9, %r12
               	shrq	$0x20, %r12
               	movw	%r12w, 0x4(%rdx)
               	shrq	$0x30, %r9
               	movb	%r9b, 0x6(%rdx)
               	movl	(%rdx), %r9d
               	movzwq	0x4(%rdx), %r12
               	movq	%r12, %r13
               	shlq	$0x20, %r13
               	movq	%r9, %r14
               	orq	%r13, %r14
               	movzbq	0x6(%rdx), %r13
               	movq	%r13, %r10
               	shlq	$0x30, %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %r14
               	shlq	$0xc, %r14
               	sarq	$0xc, %r14
               	xorq	$0x5, %r14
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %r14
               	shlq	$0x20, %r12
               	orq	%r12, %r9
               	shlq	$0x30, %r13
               	orq	%r13, %r9
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %r9
               	orq	%r14, %r9
               	movl	%r9d, (%rdx)
               	movq	%r9, %r12
               	shrq	$0x20, %r12
               	movw	%r12w, 0x4(%rdx)
               	shrq	$0x30, %r9
               	movb	%r9b, 0x6(%rdx)
               	movl	(%rdx), %r9d
               	movzwq	0x4(%rdx), %r12
               	movq	%r12, %r13
               	shlq	$0x20, %r13
               	movq	%r9, %r14
               	orq	%r13, %r14
               	movzbq	0x6(%rdx), %r13
               	movq	%r13, %r10
               	shlq	$0x30, %r10
               	movq	%r10, 0x28(%rsp)
               	orq	0x28(%rsp), %r14
               	shlq	$0xc, %r14
               	sarq	$0xc, %r14
               	cmpq	$-0x6, %r14
               	jne	<addr>
               	movzbq	-0x1(%rax), %r14
               	cmpl	$0xff, %r14d
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	shlq	$0x20, %r12
               	orq	%r12, %r9
               	shlq	$0x30, %r13
               	orq	%r13, %r9
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %r9
               	movl	%r9d, (%rdx)
               	movq	%r9, %r12
               	shrq	$0x20, %r12
               	movw	%r12w, 0x4(%rdx)
               	shrq	$0x30, %r9
               	movb	%r9b, 0x6(%rdx)
               	movl	(%rdx), %r9d
               	movzwq	0x4(%rdx), %r12
               	shlq	$0x20, %r12
               	orq	%r12, %r9
               	movzbq	0x6(%rdx), %r12
               	shlq	$0x30, %r12
               	orq	%r12, %r9
               	shlq	$0xc, %r9
               	sarq	$0xc, %r9
               	testq	%r9, %r9
               	jne	<addr>
               	movzbq	-0x1(%rax), %r9
               	cmpl	$0xf0, %r9d
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movb	$0x0, (%rbx)
               	movb	$0x0, -0xf(%rax)
               	movw	$0x0, -0xe(%rax)
               	movl	$0x0, -0xc(%rax)
               	movq	$0x0, -0x8(%rax)
               	movzbq	(%rcx), %r9
               	andq	$-0x10, %r9
               	orq	$0x9, %r9
               	movb	%r9b, (%rcx)
               	movzwq	(%rcx), %r9
               	movzbq	0x2(%rcx), %rbx
               	shlq	$0x10, %rbx
               	orq	%rbx, %r9
               	andq	$-0xfffff1, %r9         # imm = 0xFF00000F
               	orq	$0xedcbb0, %r9          # imm = 0xEDCBB0
               	movw	%r9w, (%rcx)
               	shrq	$0x10, %r9
               	movb	%r9b, 0x2(%rcx)
               	movzwq	(%rcx), %r9
               	movzbq	0x2(%rcx), %rbx
               	movq	%rbx, %r12
               	shlq	$0x10, %r12
               	orq	%r9, %r12
               	sarq	$0x4, %r12
               	shlq	$0x2c, %r12
               	sarq	$0x2c, %r12
               	cmpl	$0xfffedcbb, %r12d      # imm = 0xFFFEDCBB
               	jne	<addr>
               	movzbq	(%rcx), %r12
               	andq	$0xf, %r12
               	cmpl	$0x9, %r12d
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	shlq	$0x10, %rbx
               	orq	%rbx, %r9
               	sarq	$0x4, %r9
               	shlq	$0x2c, %r9
               	sarq	$0x2c, %r9
               	incq	%r9
               	andq	$0xfffff, %r9           # imm = 0xFFFFF
               	movzwq	(%rcx), %rbx
               	movzbq	0x2(%rcx), %r12
               	shlq	$0x10, %r12
               	orq	%r12, %rbx
               	andq	$-0xfffff1, %rbx        # imm = 0xFF00000F
               	shlq	$0x4, %r9
               	orq	%rbx, %r9
               	movw	%r9w, (%rcx)
               	shrq	$0x10, %r9
               	movb	%r9b, 0x2(%rcx)
               	movzwq	(%rcx), %r9
               	movzbq	0x2(%rcx), %rbx
               	shlq	$0x10, %rbx
               	orq	%rbx, %r9
               	sarq	$0x4, %r9
               	shlq	$0x2c, %r9
               	sarq	$0x2c, %r9
               	cmpl	$0xfffedcbc, %r9d       # imm = 0xFFFEDCBC
               	jne	<addr>
               	movzbq	(%rcx), %r9
               	andq	$0xf, %r9
               	cmpl	$0x9, %r9d
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	-0x10(%rax), %r9
               	movb	$-0x1, (%r9)
               	movb	$-0x1, -0xf(%rax)
               	movw	$0xffff, -0xe(%rax)     # imm = 0xFFFF
               	movl	$0xffffffff, -0xc(%rax) # imm = 0xFFFFFFFF
               	movq	$-0x1, -0x8(%rax)
               	movzwq	(%rcx), %rbx
               	movzbq	0x2(%rcx), %r12
               	shlq	$0x10, %r12
               	orq	%r12, %rbx
               	andq	$-0x800000, %rbx        # imm = 0xFF800000
               	orq	$0x2aaaaa, %rbx         # imm = 0x2AAAAA
               	movw	%bx, (%rcx)
               	shrq	$0x10, %rbx
               	movb	%bl, 0x2(%rcx)
               	movzwq	(%rcx), %rbx
               	movzbq	0x2(%rcx), %rcx
               	shlq	$0x10, %rcx
               	orq	%rbx, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	cmpl	$0x2aaaaa, %ecx         # imm = 0x2AAAAA
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0xaa, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movb	$0x0, (%r9)
               	movb	$0x0, -0xf(%rax)
               	movw	$0x0, -0xe(%rax)
               	movl	$0x0, -0xc(%rax)
               	movq	$0x0, -0x8(%rax)
               	movb	$0x5a, (%rdx)
               	movl	0x1(%rdx), %ecx
               	movzwq	0x5(%rdx), %r9
               	shlq	$0x20, %r9
               	orq	%r9, %rcx
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rcx
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	orq	%r11, %rcx
               	movl	%ecx, 0x1(%rdx)
               	shrq	$0x20, %rcx
               	movw	%cx, 0x5(%rdx)
               	movl	0x1(%rdx), %ecx
               	movzwq	0x5(%rdx), %r9
               	movq	%r9, %rbx
               	shlq	$0x20, %rbx
               	orq	%rcx, %rbx
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	cmpq	%r11, %rbx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rbx
               	cmpl	$0xfe, %ebx
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	%r9, %rbx
               	shlq	$0x20, %rbx
               	orq	%rcx, %rbx
               	shrq	$0x4, %rbx
               	shlq	$0x20, %r9
               	orq	%r9, %rcx
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rcx
               	orq	%rbx, %rcx
               	movl	%ecx, 0x1(%rdx)
               	shrq	$0x20, %rcx
               	movw	%cx, 0x5(%rdx)
               	movl	0x1(%rdx), %ecx
               	movzwq	0x5(%rdx), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$0xfedcba98765, %r11    # imm = 0xFEDCBA98765
               	cmpq	%r11, %rcx
               	jne	<addr>
               	leaq	-0x20(%rax), %rdx
               	movb	$-0x1, (%rdx)
               	movb	$-0x1, -0x1f(%rax)
               	movw	$0xffff, -0x1e(%rax)    # imm = 0xFFFF
               	movl	$0xffffffff, -0x1c(%rax) # imm = 0xFFFFFFFF
               	movq	$-0x1, -0x18(%rax)
               	movq	$-0x1, -0x10(%rax)
               	movq	$-0x1, -0x8(%rax)
               	movb	$0x3, (%rdi)
               	movl	0x9(%rdi), %ecx
               	movzbq	0xd(%rdi), %r9
               	shlq	$0x20, %r9
               	orq	%r9, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x123456789abcdf0, %r9 # imm = 0xFEDCBA9876543210
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	orq	%r11, %rcx
               	movq	%r9, 0x1(%rdi)
               	movl	%ecx, 0x9(%rdi)
               	shrq	$0x20, %rcx
               	movb	%cl, 0xd(%rdi)
               	movl	0x9(%rdi), %r9d
               	movzbq	0xd(%rdi), %rbx
               	movq	%rbx, %rcx
               	shlq	$0x20, %rcx
               	orq	%r9, %rcx
               	shlq	$0x1c, %rcx
               	orq	$0xfedcba9, %rcx        # imm = 0xFEDCBA9
               	movq	%rcx, %r13
               	sarq	$0x1c, %r13
               	shlq	$0x24, %rcx
               	movabsq	$0x876543210, %r12      # imm = 0x876543210
               	orq	%rcx, %r12
               	leaq	0x1(%r12), %rcx
               	cmpq	%r12, %rcx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	addq	%r13, %r12
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %r12
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r9
               	orq	%r12, %r9
               	movq	%rcx, 0x1(%rdi)
               	movl	%r9d, 0x9(%rdi)
               	shrq	$0x20, %r9
               	movb	%r9b, 0xd(%rdi)
               	movl	0x9(%rdi), %r9d
               	movzbq	0xd(%rdi), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movq	%rcx, %rbx
               	shlq	$0x1c, %rbx
               	shlq	$0x1c, %r9
               	shrq	$0x24, %rcx
               	orq	%r9, %rcx
               	movq	%rcx, %r9
               	sarq	$0x1c, %r9
               	shrq	$0x1c, %rbx
               	shlq	$0x24, %rcx
               	orq	%rbx, %rcx
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	xorq	%r11, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0xf1, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	$-0x2, %rcx
               	movl	0x9(%rdi), %r9d
               	movzbq	0xd(%rdi), %rbx
               	shlq	$0x20, %rbx
               	orq	%rbx, %r9
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %r9
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %r9
               	movq	%rcx, 0x1(%rdi)
               	movl	%r9d, 0x9(%rdi)
               	shrq	$0x20, %r9
               	movb	%r9b, 0xd(%rdi)
               	movl	0x9(%rdi), %r9d
               	movzbq	0xd(%rdi), %rdi
               	shlq	$0x20, %rdi
               	orq	%r9, %rdi
               	shlq	$0x1c, %rdi
               	orq	$0xfffffff, %rdi        # imm = 0xFFFFFFF
               	movq	%rdi, %r9
               	sarq	$0x1c, %r9
               	shlq	$0x24, %rdi
               	movabsq	$0xffffffffe, %r11      # imm = 0xFFFFFFFFE
               	orq	%r11, %rdi
               	xorq	%rdi, %rcx
               	xorq	$-0x1, %r9
               	orq	%r9, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0xff, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movb	%cl, (%rdx)
               	movb	%cl, -0x1f(%rax)
               	movw	$0x0, -0x1e(%rax)
               	movl	$0x0, -0x1c(%rax)
               	movq	$0x0, -0x18(%rax)
               	movq	$0x0, -0x10(%rax)
               	movq	$0x0, -0x8(%rax)
               	movzbq	(%r8), %rdi
               	andq	$-0x2, %rdi
               	orq	$0x1, %rdi
               	movb	%dil, (%r8)
               	movzbq	0x8(%r8), %rdi
               	andq	$-0xff, %rdi
               	orq	$0xaa, %rdi
               	movb	%dil, 0x8(%r8)
               	movq	(%r8), %rdi
               	movzbq	0x8(%r8), %r9
               	andq	$0x1, %rdi
               	andq	$-0x2, %r9
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	orq	%r11, %rdi
               	orq	$0x1, %r9
               	movq	%rdi, (%r8)
               	movb	%r9b, 0x8(%r8)
               	movzbq	0x8(%r8), %r9
               	shrq	%rdi
               	movq	%r9, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rdi
               	movabsq	$-0x7edcba9876543211, %r11 # imm = 0x8123456789ABCDEF
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movzbq	(%r8), %rdi
               	andq	$0x1, %rdi
               	cmpl	$0x1, %edi
               	jne	<addr>
               	sarq	%r9
               	cmpl	$0x55, %r9d
               	jne	<addr>
               	movzbq	-0x1(%rax), %rdi
               	cmpl	$0xab, %edi
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%r8), %rdi
               	movzbq	0x8(%r8), %r9
               	movq	%rdi, %rbx
               	shrq	%rbx
               	movq	%r9, %r12
               	shlq	$0x3f, %r12
               	orq	%r12, %rbx
               	cmpq	$-0x3, %rbx
               	setae	%bl
               	movzbq	%bl, %rbx
               	shlq	%rbx
               	andq	$0x1, %rdi
               	andq	$-0x2, %r9
               	orq	%rbx, %rdi
               	movq	%rdi, (%r8)
               	movb	%r9b, 0x8(%r8)
               	movzbq	0x8(%r8), %r9
               	shrq	%rdi
               	movq	%r9, %rbx
               	shlq	$0x3f, %rbx
               	orq	%rbx, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movzbq	(%r8), %rdi
               	andq	$0x1, %rdi
               	cmpl	$0x1, %edi
               	jne	<addr>
               	sarq	%r9
               	cmpl	$0x55, %r9d
               	jne	<addr>
               	movzbq	-0x1(%rax), %rdi
               	cmpl	$0xaa, %edi
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movb	%cl, (%rdx)
               	movb	%cl, -0x1f(%rax)
               	movw	$0x0, -0x1e(%rax)
               	movl	$0x0, -0x1c(%rax)
               	movq	$0x0, -0x18(%rax)
               	movq	$0x0, -0x10(%rax)
               	movq	$0x0, -0x8(%rax)
               	movzbq	(%rsi), %rdx
               	andq	$-0x2, %rdx
               	orq	$0x1, %rdx
               	movb	%dl, (%rsi)
               	movzbq	0x10(%rsi), %rdx
               	andq	$-0xff, %rdx
               	orq	$0x54, %rdx
               	movb	%dl, 0x10(%rsi)
               	movq	(%rsi), %rdx
               	movzbq	0x10(%rsi), %rdi
               	andq	$0x1, %rdx
               	movabsq	$-0x2468acf13579be0, %r11 # imm = 0xFDB97530ECA86420
               	orq	%r11, %rdx
               	movabsq	$0x2468acf13579bdf, %r8 # imm = 0x2468ACF13579BDF
               	movq	%rdx, (%rsi)
               	movq	%r8, 0x8(%rsi)
               	andq	$-0x2, %rdi
               	movb	%dil, 0x10(%rsi)
               	movzbq	0x10(%rsi), %rdi
               	shrq	%rdx
               	movabsq	$-0x8000000000000000, %r8 # imm = 0x8000000000000000
               	orq	%rdx, %r8
               	movq	%rdi, %rdx
               	shlq	$0x3f, %rdx
               	movabsq	$0x123456789abcdef, %r9 # imm = 0x123456789ABCDEF
               	orq	%rdx, %r9
               	leaq	0x1(%r8), %rdx
               	cmpq	%r8, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	addq	%r9, %r8
               	movq	%rdx, %r9
               	shlq	%r9
               	movq	%r8, %rbx
               	shlq	%rbx
               	shrq	$0x3f, %rdx
               	orq	%rdx, %rbx
               	movq	(%rsi), %rdx
               	andq	$0x1, %rdx
               	orq	%r9, %rdx
               	orq	%rbx, %rcx
               	movq	%rdx, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	shrq	$0x3f, %r8
               	andq	$-0x2, %rdi
               	orq	%r8, %rdi
               	movb	%dil, 0x10(%rsi)
               	movzbq	0x10(%rsi), %rdi
               	movq	%rcx, %r8
               	shrq	%r8
               	shrq	%rdx
               	shlq	$0x3f, %rcx
               	orq	%rdx, %rcx
               	movq	%rdi, %rdx
               	shlq	$0x3f, %rdx
               	orq	%r8, %rdx
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	xorq	%r11, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%rsi), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	sarq	%rdi
               	cmpl	$0x2a, %edi
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0x54, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movq	(%rsi), %rcx
               	movzbq	0x10(%rsi), %rdx
               	andq	$0x1, %rcx
               	orq	$-0x2, %rcx
               	movq	%rcx, (%rsi)
               	movq	$-0x1, 0x8(%rsi)
               	andq	$-0x2, %rdx
               	orq	$0x1, %rdx
               	movb	%dl, 0x10(%rsi)
               	movzbq	0x10(%rsi), %rdx
               	shrq	%rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	movq	%rdx, %rdi
               	shlq	$0x3f, %rdi
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	orq	%r11, %rdi
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdi
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	(%rsi), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	sarq	%rdx
               	cmpl	$0x2a, %edx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rax
               	cmpl	$0x55, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
