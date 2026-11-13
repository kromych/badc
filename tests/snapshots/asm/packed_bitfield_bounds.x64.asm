
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
               	subq	$0x20, %rsp
               	movl	$0x1e, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%edi, %edi
               	movq	%r9, %rsi
               	shlq	%rsi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	movq	%r9, 0x10(%rsp)
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x10(%rsp), %r9
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	leaq	(%rcx,%r9), %rdi
               	xorl	%edx, %edx
               	movq	%r9, 0x10(%rsp)
               	movq	%rcx, 0x8(%rsp)
               	movq	%r9, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x10(%rsp), %r9
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	(%rcx,%r9), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, -0x10(%rax)
               	movq	$-0x1, -0x8(%rax)
               	movzwq	-0x3(%rax), %rcx
               	movzbq	-0x1(%rax), %rdx
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	andq	$-0x400000, %rcx        # imm = 0xFFC00000
               	orq	$0x3ffffb, %rcx         # imm = 0x3FFFFB
               	movw	%cx, -0x3(%rax)
               	shrq	$0x10, %rcx
               	movb	%cl, -0x1(%rax)
               	movzwq	-0x3(%rax), %rcx
               	movzbq	-0x1(%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x10, %rsi
               	orq	%rcx, %rsi
               	shlq	$0x2a, %rsi
               	sarq	$0x2a, %rsi
               	addq	$0x7, %rsi
               	andq	$0x3fffff, %rsi         # imm = 0x3FFFFF
               	shlq	$0x10, %rdx
               	orq	%rdx, %rcx
               	andq	$-0x400000, %rcx        # imm = 0xFFC00000
               	orq	%rsi, %rcx
               	movw	%cx, -0x3(%rax)
               	shrq	$0x10, %rcx
               	movb	%cl, -0x1(%rax)
               	movzwq	-0x3(%rax), %rdx
               	movzbq	-0x1(%rax), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x2a, %rdx
               	sarq	$0x2a, %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	cmpl	$0xc0, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	$-0x1, -0x10(%rax)
               	movq	$-0x1, -0x8(%rax)
               	movl	-0x5(%rax), %ecx
               	movzbq	-0x1(%rax), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0xedcba9877, %r11      # imm = 0xEDCBA9877
               	orq	%r11, %rcx
               	movl	%ecx, -0x5(%rax)
               	shrq	$0x20, %rcx
               	movb	%cl, -0x1(%rax)
               	movl	-0x5(%rax), %edx
               	movzbq	-0x1(%rax), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x20, %rsi
               	orq	%rdx, %rsi
               	shlq	$0x1c, %rsi
               	sarq	$0x1c, %rsi
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rsi
               	jne	<addr>
               	cmpl	$0xfe, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	shlq	$0x20, %rcx
               	orq	%rdx, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	$0x5, %rcx
               	movl	%ecx, -0x5(%rax)
               	shrq	$0x20, %rcx
               	movb	%cl, -0x1(%rax)
               	movl	-0x5(%rax), %edx
               	movzbq	-0x1(%rax), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x1c, %rdx
               	sarq	$0x1c, %rdx
               	cmpq	$0x5, %rdx
               	jne	<addr>
               	cmpl	$0xf0, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	$-0x1, -0x10(%rax)
               	movq	$-0x1, -0x8(%rax)
               	movl	-0x6(%rax), %ecx
               	movzwq	-0x2(%rax), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rcx
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	orq	%r11, %rcx
               	movl	%ecx, -0x6(%rax)
               	shrq	$0x20, %rcx
               	movw	%cx, -0x2(%rax)
               	movl	-0x6(%rax), %ecx
               	movzwq	-0x2(%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x20, %rsi
               	orq	%rcx, %rsi
               	shlq	$0x14, %rsi
               	sarq	$0x14, %rsi
               	decq	%rsi
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rsi
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rcx
               	orq	%rsi, %rcx
               	movl	%ecx, -0x6(%rax)
               	shrq	$0x20, %rcx
               	movw	%cx, -0x2(%rax)
               	movl	-0x6(%rax), %ecx
               	movzwq	-0x2(%rax), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	shlq	$0x14, %rcx
               	sarq	$0x14, %rcx
               	movabsq	$0x7fffffffffe, %r11    # imm = 0x7FFFFFFFFFE
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0xf7, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	$-0x1, -0x10(%rax)
               	movq	$-0x1, -0x8(%rax)
               	movl	-0x7(%rax), %ecx
               	movzwq	-0x3(%rax), %rdx
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movzbq	-0x1(%rax), %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	orq	%r11, %rcx
               	movl	%ecx, -0x7(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movw	%dx, -0x3(%rax)
               	shrq	$0x30, %rcx
               	movb	%cl, -0x1(%rax)
               	movl	-0x7(%rax), %ecx
               	movzwq	-0x3(%rax), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x20, %rsi
               	movq	%rcx, %rdi
               	orq	%rsi, %rdi
               	movzbq	-0x1(%rax), %rsi
               	movq	%rsi, %r8
               	shlq	$0x30, %r8
               	orq	%r8, %rdi
               	shlq	$0xc, %rdi
               	sarq	$0xc, %rdi
               	xorq	$0x5, %rdi
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdi
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	shlq	$0x30, %rsi
               	orq	%rsi, %rcx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rcx
               	orq	%rdi, %rcx
               	movl	%ecx, -0x7(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movw	%dx, -0x3(%rax)
               	shrq	$0x30, %rcx
               	movb	%cl, -0x1(%rax)
               	movl	-0x7(%rax), %edx
               	movzwq	-0x3(%rax), %rsi
               	movq	%rsi, %rcx
               	shlq	$0x20, %rcx
               	movq	%rdx, %rdi
               	orq	%rcx, %rdi
               	movzbq	-0x1(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	$0x30, %r8
               	orq	%r8, %rdi
               	shlq	$0xc, %rdi
               	sarq	$0xc, %rdi
               	cmpq	$-0x6, %rdi
               	jne	<addr>
               	cmpl	$0xff, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x30, %rcx
               	orq	%rdx, %rcx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rcx
               	movl	%ecx, -0x7(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movw	%dx, -0x3(%rax)
               	shrq	$0x30, %rcx
               	movb	%cl, -0x1(%rax)
               	movl	-0x7(%rax), %ecx
               	movzwq	-0x3(%rax), %rdx
               	shlq	$0x20, %rdx
               	orq	%rcx, %rdx
               	movzbq	-0x1(%rax), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x30, %rsi
               	orq	%rsi, %rdx
               	shlq	$0xc, %rdx
               	sarq	$0xc, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0xf0, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	$0x0, -0x10(%rax)
               	movq	$0x0, -0x8(%rax)
               	movzbq	-0x3(%rax), %rcx
               	andq	$-0x10, %rcx
               	orq	$0x9, %rcx
               	movb	%cl, -0x3(%rax)
               	movzwq	-0x3(%rax), %rcx
               	movzbq	-0x1(%rax), %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rcx
               	andq	$-0xfffff1, %rcx        # imm = 0xFF00000F
               	orq	$0xedcbb0, %rcx         # imm = 0xEDCBB0
               	movw	%cx, -0x3(%rax)
               	shrq	$0x10, %rcx
               	movb	%cl, -0x1(%rax)
               	movzwq	-0x3(%rax), %rcx
               	movzbq	-0x1(%rax), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x10, %rdi
               	orq	%rcx, %rdi
               	sarq	$0x4, %rdi
               	shlq	$0x2c, %rdi
               	sarq	$0x2c, %rdi
               	cmpl	$0xfffedcbb, %edi       # imm = 0xFFFEDCBB
               	jne	<addr>
               	movzbq	-0x3(%rax), %rdi
               	andq	$0xf, %rdi
               	cmpl	$0x9, %edi
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	shlq	$0x10, %rsi
               	orq	%rsi, %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	incq	%rcx
               	andq	$0xfffff, %rcx          # imm = 0xFFFFF
               	movzwq	-0x3(%rax), %rsi
               	movzbq	-0x1(%rax), %rdi
               	shlq	$0x10, %rdi
               	orq	%rdi, %rsi
               	andq	$-0xfffff1, %rsi        # imm = 0xFF00000F
               	shlq	$0x4, %rcx
               	orq	%rsi, %rcx
               	movw	%cx, -0x3(%rax)
               	shrq	$0x10, %rcx
               	movb	%cl, -0x1(%rax)
               	movzwq	-0x3(%rax), %rcx
               	movzbq	-0x1(%rax), %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	cmpl	$0xfffedcbc, %ecx       # imm = 0xFFFEDCBC
               	jne	<addr>
               	movzbq	-0x3(%rax), %rcx
               	andq	$0xf, %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	$-0x1, -0x10(%rax)
               	movq	$-0x1, -0x8(%rax)
               	movzwq	-0x3(%rax), %rcx
               	movzbq	-0x1(%rax), %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rcx
               	andq	$-0x800000, %rcx        # imm = 0xFF800000
               	orq	$0x2aaaaa, %rcx         # imm = 0x2AAAAA
               	movw	%cx, -0x3(%rax)
               	shrq	$0x10, %rcx
               	movb	%cl, -0x1(%rax)
               	movzwq	-0x3(%rax), %rsi
               	movzbq	-0x1(%rax), %rcx
               	movq	%rcx, %rdi
               	shlq	$0x10, %rdi
               	orq	%rdi, %rsi
               	andq	$0x7fffff, %rsi         # imm = 0x7FFFFF
               	cmpl	$0x2aaaaa, %esi         # imm = 0x2AAAAA
               	jne	<addr>
               	cmpl	$0xaa, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	$0x0, -0x10(%rax)
               	movq	$0x5a00, -0x8(%rax)     # imm = 0x5A00
               	movl	-0x6(%rax), %ecx
               	movzwq	-0x2(%rax), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rcx
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rcx
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	orq	%r11, %rcx
               	movl	%ecx, -0x6(%rax)
               	shrq	$0x20, %rcx
               	movw	%cx, -0x2(%rax)
               	movl	-0x6(%rax), %ecx
               	movzwq	-0x2(%rax), %rsi
               	movq	%rsi, %rdi
               	shlq	$0x20, %rdi
               	orq	%rcx, %rdi
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movzbq	-0x1(%rax), %rdi
               	cmpl	$0xfe, %edi
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	%rsi, %rdi
               	shlq	$0x20, %rdi
               	orq	%rcx, %rdi
               	shrq	$0x4, %rdi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rcx
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rcx
               	orq	%rdi, %rcx
               	movl	%ecx, -0x6(%rax)
               	shrq	$0x20, %rcx
               	movw	%cx, -0x2(%rax)
               	movl	-0x6(%rax), %ecx
               	movzwq	-0x2(%rax), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rcx
               	movabsq	$0xfedcba98765, %r11    # imm = 0xFEDCBA98765
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	$-0x1, -0x20(%rax)
               	movq	$-0x1, -0x18(%rax)
               	movw	$0xffff, -0x10(%rax)    # imm = 0xFFFF
               	movb	$-0x1, -0x5(%rax)
               	movl	$0xffffffff, -0x4(%rax) # imm = 0xFFFFFFFF
               	movb	$0x3, -0xe(%rax)
               	movl	-0x5(%rax), %ecx
               	movzbq	-0x1(%rax), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	orq	%r11, %rcx
               	movl	%ecx, -0x5(%rax)
               	shrq	$0x20, %rcx
               	movb	%cl, -0x1(%rax)
               	movl	-0x5(%rax), %esi
               	movzbq	-0x1(%rax), %rdi
               	movq	%rdi, %rcx
               	shlq	$0x20, %rcx
               	orq	%rsi, %rcx
               	shlq	$0x1c, %rcx
               	orq	$0xfedcba9, %rcx        # imm = 0xFEDCBA9
               	movq	%rcx, %r9
               	sarq	$0x1c, %r9
               	shlq	$0x24, %rcx
               	movabsq	$0x876543210, %r8       # imm = 0x876543210
               	orq	%rcx, %r8
               	leaq	0x1(%r8), %rcx
               	cmpq	%r8, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	addq	%r9, %r8
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %r8
               	shlq	$0x20, %rdi
               	orq	%rdi, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	orq	%r8, %rsi
               	movq	%rcx, -0xd(%rax)
               	movl	%esi, -0x5(%rax)
               	shrq	$0x20, %rsi
               	movb	%sil, -0x1(%rax)
               	movl	-0x5(%rax), %edi
               	movzbq	-0x1(%rax), %rsi
               	movq	%rsi, %r8
               	shlq	$0x20, %r8
               	orq	%r8, %rdi
               	movq	%rcx, %r8
               	shlq	$0x1c, %r8
               	shlq	$0x1c, %rdi
               	shrq	$0x24, %rcx
               	orq	%rdi, %rcx
               	movq	%rcx, %rdi
               	sarq	$0x1c, %rdi
               	shrq	$0x1c, %r8
               	shlq	$0x24, %rcx
               	orq	%r8, %rcx
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	xorq	%r11, %rdi
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0xf1, %esi
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	$-0x2, %rcx
               	movl	-0x5(%rax), %esi
               	movzbq	-0x1(%rax), %rdi
               	shlq	$0x20, %rdi
               	orq	%rdi, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rsi
               	movq	%rcx, -0xd(%rax)
               	movl	%esi, -0x5(%rax)
               	shrq	$0x20, %rsi
               	movb	%sil, -0x1(%rax)
               	movl	-0x5(%rax), %edi
               	movzbq	-0x1(%rax), %rsi
               	movq	%rsi, %r8
               	shlq	$0x20, %r8
               	orq	%r8, %rdi
               	shlq	$0x1c, %rdi
               	orq	$0xfffffff, %rdi        # imm = 0xFFFFFFF
               	movq	%rdi, %r8
               	sarq	$0x1c, %r8
               	shlq	$0x24, %rdi
               	movabsq	$0xffffffffe, %r11      # imm = 0xFFFFFFFFE
               	orq	%r11, %rdi
               	xorq	%rdi, %rcx
               	xorq	$-0x1, %r8
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0xff, %esi
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	$0x0, -0x20(%rax)
               	movq	$0x0, -0x18(%rax)
               	movq	$0x0, -0x10(%rax)
               	movq	$0x0, -0x8(%rax)
               	movzbq	-0x9(%rax), %rcx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movb	%cl, -0x9(%rax)
               	movzbq	-0x1(%rax), %rcx
               	andq	$-0xff, %rcx
               	orq	$0xaa, %rcx
               	movb	%cl, -0x1(%rax)
               	movq	-0x9(%rax), %rcx
               	movzbq	-0x1(%rax), %rsi
               	andq	$0x1, %rcx
               	movq	%rsi, %rdi
               	andq	$-0x2, %rdi
               	movabsq	$0x2468acf13579bde, %rsi # imm = 0x2468ACF13579BDE
               	orq	%rcx, %rsi
               	orq	$0x1, %rdi
               	movq	%rsi, -0x9(%rax)
               	movb	%dil, -0x1(%rax)
               	movzbq	-0x1(%rax), %rcx
               	shrq	%rsi
               	movq	%rcx, %rdi
               	shlq	$0x3f, %rdi
               	orq	%rdi, %rsi
               	movabsq	$-0x7edcba9876543211, %r11 # imm = 0x8123456789ABCDEF
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movzbq	-0x9(%rax), %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	%rcx, %rsi
               	sarq	%rsi
               	cmpl	$0x55, %esi
               	jne	<addr>
               	cmpl	$0xab, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	movq	-0x9(%rax), %rcx
               	movzbq	-0x1(%rax), %rsi
               	movq	%rcx, %rdi
               	shrq	%rdi
               	movq	%rsi, %r8
               	shlq	$0x3f, %r8
               	orq	%r8, %rdi
               	cmpq	$-0x3, %rdi
               	setae	%dil
               	movzbq	%dil, %rdi
               	shlq	%rdi
               	andq	$0x1, %rcx
               	movq	%rsi, %r8
               	andq	$-0x2, %r8
               	movq	%rcx, %rsi
               	orq	%rdi, %rsi
               	movq	%rsi, -0x9(%rax)
               	movb	%r8b, -0x1(%rax)
               	movzbq	-0x1(%rax), %rcx
               	shrq	%rsi
               	movq	%rcx, %rdi
               	shlq	$0x3f, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movzbq	-0x9(%rax), %rsi
               	andq	$0x1, %rsi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	%rcx, %rsi
               	sarq	%rsi
               	cmpl	$0x55, %esi
               	jne	<addr>
               	cmpl	$0xaa, %ecx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	movq	$0x0, -0x20(%rax)
               	movq	$0x0, -0x18(%rax)
               	movl	$0x0, -0x10(%rax)
               	movw	$0x0, -0xc(%rax)
               	movb	%dl, -0xa(%rax)
               	movb	%dl, -0x1(%rax)
               	movzbq	-0x11(%rax), %rcx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movb	%cl, -0x11(%rax)
               	movzbq	-0x1(%rax), %rcx
               	andq	$-0xff, %rcx
               	orq	$0x54, %rcx
               	movb	%cl, -0x1(%rax)
               	movq	-0x11(%rax), %rcx
               	movzbq	-0x1(%rax), %rsi
               	andq	$0x1, %rcx
               	movabsq	$-0x2468acf13579be0, %r11 # imm = 0xFDB97530ECA86420
               	orq	%r11, %rcx
               	movq	%rcx, -0x11(%rax)
               	andq	$-0x2, %rsi
               	movb	%sil, -0x1(%rax)
               	movzbq	-0x1(%rax), %rsi
               	shrq	%rcx
               	movabsq	$-0x8000000000000000, %rdi # imm = 0x8000000000000000
               	orq	%rcx, %rdi
               	movq	%rsi, %rcx
               	shlq	$0x3f, %rcx
               	movabsq	$0x123456789abcdef, %r8 # imm = 0x123456789ABCDEF
               	orq	%rcx, %r8
               	leaq	0x1(%rdi), %rcx
               	cmpq	%rdi, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	addq	%r8, %rdi
               	movq	%rcx, %r8
               	shlq	%r8
               	movq	%rdi, %r9
               	shlq	%r9
               	shrq	$0x3f, %rcx
               	orq	%rcx, %r9
               	movq	-0x11(%rax), %rcx
               	andq	$0x1, %rcx
               	orq	%r8, %rcx
               	orq	%r9, %rdx
               	movq	%rcx, -0x11(%rax)
               	movq	%rdx, -0x9(%rax)
               	shrq	$0x3f, %rdi
               	andq	$-0x2, %rsi
               	orq	%rdi, %rsi
               	movb	%sil, -0x1(%rax)
               	movzbq	-0x1(%rax), %rsi
               	movq	%rdx, %rdi
               	shrq	%rdi
               	shrq	%rcx
               	shlq	$0x3f, %rdx
               	orq	%rdx, %rcx
               	movq	%rsi, %rdx
               	shlq	$0x3f, %rdx
               	orq	%rdi, %rdx
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	xorq	%r11, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x11(%rax), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	sarq	%rsi
               	cmpl	$0x2a, %esi
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0x54, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	-0x11(%rax), %rdx
               	andq	$0x1, %rdx
               	orq	$-0x2, %rdx
               	movq	%rdx, -0x11(%rax)
               	movq	$-0x1, -0x9(%rax)
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movb	%cl, -0x1(%rax)
               	movzbq	-0x1(%rax), %rcx
               	shrq	%rdx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x3f, %rsi
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	orq	%r11, %rsi
               	xorq	$-0x1, %rdx
               	xorq	$-0x1, %rsi
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	-0x11(%rax), %rax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%rcx, %rax
               	sarq	%rax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	cmpl	$0x55, %ecx
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xd, %eax
               	leave
               	retq
