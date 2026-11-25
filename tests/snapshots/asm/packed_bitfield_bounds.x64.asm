
packed_bitfield_bounds.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x18, %rsp
               	movl	$0x1e, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	movq	%r9, %rsi
               	shlq	%rsi
               	movq	%r9, 0x8(%rsp)
               	xorl	%edi, %edi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	xorl	%r9d, %r9d
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x8(%rsp), %r9
               	cmpq	$-0x1, %rcx
               	je	<addr>
               	leaq	(%rcx,%r9), %rdi
               	movq	%r9, 0x8(%rsp)
               	movq	%rcx, (%rsp)
               	movq	%r9, %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %r9
               	movq	(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	(%rcx,%r9), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	$-0x1, -0x10(%rax)
               	movl	$0xffffffff, -0x8(%rax) # imm = 0xFFFFFFFF
               	movw	$0xffff, -0x4(%rax)     # imm = 0xFFFF
               	movb	$-0x1, -0x2(%rax)
               	movzwq	-0x3(%rax), %rcx
               	orq	$0xff0000, %rcx         # imm = 0xFF0000
               	andq	$-0x400000, %rcx        # imm = 0xFFC00000
               	orq	$0x3ffffb, %rcx         # imm = 0x3FFFFB
               	movq	%rcx, %rdi
               	shrq	$0x10, %rdi
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rdi, %rdx
               	shlq	$0x10, %rdx
               	orq	%rcx, %rdx
               	shlq	$0x2a, %rdx
               	sarq	$0x2a, %rdx
               	addq	$0x7, %rdx
               	andq	$0x3fffff, %rdx         # imm = 0x3FFFFF
               	shlq	$0x10, %rdi
               	orq	%rdi, %rcx
               	andq	$-0x400000, %rcx        # imm = 0xFFC00000
               	orq	%rdx, %rcx
               	movw	%cx, -0x3(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x10, %rdx
               	movb	%dl, -0x1(%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rdx, %rdi
               	shlq	$0x10, %rdi
               	orq	%rdi, %rcx
               	shlq	$0x2a, %rcx
               	sarq	$0x2a, %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	cmpl	$0xc0, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movb	$-0x1, -0x3(%rax)
               	movb	$-0x1, -0x2(%rax)
               	movl	-0x5(%rax), %ecx
               	movabsq	$0xff00000000, %r11     # imm = 0xFF00000000
               	orq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0xedcba9877, %rdx      # imm = 0xEDCBA9877
               	orq	%rcx, %rdx
               	movl	%edx, -0x5(%rax)
               	movq	%rdx, %rcx
               	shrq	$0x20, %rcx
               	movb	%cl, -0x1(%rax)
               	movl	%edx, %edi
               	movq	%rcx, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdi, %rdx
               	shlq	$0x1c, %rdx
               	sarq	$0x1c, %rdx
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rdx
               	jne	<addr>
               	cmpl	$0xfe, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdi
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rdi, %rcx
               	orq	$0x5, %rcx
               	movl	%ecx, -0x5(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movb	%dl, -0x1(%rax)
               	movl	%ecx, %ecx
               	movq	%rdx, %rdi
               	shlq	$0x20, %rdi
               	orq	%rdi, %rcx
               	shlq	$0x1c, %rcx
               	sarq	$0x1c, %rcx
               	cmpq	$0x5, %rcx
               	jne	<addr>
               	cmpl	$0xf0, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movb	$-0x1, -0x5(%rax)
               	movl	$0xffffffff, -0x4(%rax) # imm = 0xFFFFFFFF
               	movl	-0x6(%rax), %edx
               	movzwq	-0x2(%rax), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdx
               	movabsq	$-0x100000000000, %rcx  # imm = 0xFFFFF00000000000
               	andq	%rdx, %rcx
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	orq	%r11, %rcx
               	shrq	$0x20, %rcx
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movq	%rcx, %rdx
               	shlq	$0x20, %rdx
               	orq	%rdi, %rdx
               	shlq	$0x14, %rdx
               	sarq	$0x14, %rdx
               	decq	%rdx
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rdx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdi
               	movabsq	$-0x100000000000, %rcx  # imm = 0xFFFFF00000000000
               	andq	%rdi, %rcx
               	orq	%rdx, %rcx
               	movl	%ecx, -0x6(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movw	%dx, -0x2(%rax)
               	movl	%ecx, %ecx
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
               	addq	$0x18, %rsp
               	retq
               	movw	$0xffff, -0x6(%rax)     # imm = 0xFFFF
               	movw	$0xffff, -0x4(%rax)     # imm = 0xFFFF
               	movb	$-0x1, -0x2(%rax)
               	movl	-0x7(%rax), %edx
               	movzwq	-0x3(%rax), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdx
               	movabsq	$0xff000000000000, %rcx # imm = 0xFF000000000000
               	orq	%rdx, %rcx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rcx
               	movabsq	$0xfffffffffffff, %rdx  # imm = 0xFFFFFFFFFFFFF
               	orq	%rcx, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x20, %rdi
               	shrq	$0x30, %rdx
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rdi, %rcx
               	shlq	$0x20, %rcx
               	orq	%r8, %rcx
               	movq	%rdx, %r9
               	shlq	$0x30, %r9
               	orq	%r9, %rcx
               	shlq	$0xc, %rcx
               	sarq	$0xc, %rcx
               	xorq	$0x5, %rcx
               	movabsq	$0xfffffffffffff, %r9   # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %r9
               	shlq	$0x20, %rdi
               	orq	%rdi, %r8
               	shlq	$0x30, %rdx
               	orq	%rdx, %r8
               	movabsq	$-0x10000000000000, %rcx # imm = 0xFFF0000000000000
               	andq	%r8, %rcx
               	orq	%r9, %rcx
               	movl	%ecx, -0x7(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movw	%dx, -0x3(%rax)
               	movq	%rcx, %r8
               	shrq	$0x30, %r8
               	movb	%r8b, -0x1(%rax)
               	movl	%ecx, %edi
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rdx, %rcx
               	shlq	$0x20, %rcx
               	orq	%rdi, %rcx
               	movq	%r8, %r9
               	shlq	$0x30, %r9
               	orq	%r9, %rcx
               	shlq	$0xc, %rcx
               	sarq	$0xc, %rcx
               	cmpq	$-0x6, %rcx
               	jne	<addr>
               	cmpl	$0xff, %r8d
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	shlq	$0x20, %rdx
               	orq	%rdx, %rdi
               	movzbq	-0x1(%rax), %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rdi
               	movabsq	$-0x10000000000000, %rcx # imm = 0xFFF0000000000000
               	andq	%rdi, %rcx
               	movl	%ecx, -0x7(%rax)
               	movq	%rcx, %rdx
               	shrq	$0x20, %rdx
               	movw	%dx, -0x3(%rax)
               	movq	%rcx, %rdi
               	shrq	$0x30, %rdi
               	movb	%dil, -0x1(%rax)
               	movl	%ecx, %ecx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	shlq	$0x20, %rdx
               	orq	%rdx, %rcx
               	movq	%rdi, %rdx
               	shlq	$0x30, %rdx
               	orq	%rdx, %rcx
               	shlq	$0xc, %rcx
               	sarq	$0xc, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpl	$0xf0, %edi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%edx, %edx
               	movq	$0x0, -0x10(%rax)
               	movl	$0x0, -0x8(%rax)
               	movb	%dl, -0x4(%rax)
               	movb	%dl, -0x2(%rax)
               	movb	$0x9, -0x3(%rax)
               	movzwq	-0x3(%rax), %rcx
               	andq	$-0xfffff1, %rcx        # imm = 0xFF00000F
               	orq	$0xedcbb0, %rcx         # imm = 0xEDCBB0
               	movw	%cx, -0x3(%rax)
               	movq	%rcx, %r8
               	shrq	$0x10, %r8
               	movb	%r8b, -0x1(%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%r8, %rdi
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
               	addq	$0x18, %rsp
               	retq
               	shlq	$0x10, %r8
               	orq	%r8, %rcx
               	sarq	$0x4, %rcx
               	shlq	$0x2c, %rcx
               	sarq	$0x2c, %rcx
               	leaq	0x1(%rcx), %rdi
               	andq	$0xfffff, %rdi          # imm = 0xFFFFF
               	movzwq	-0x3(%rax), %rcx
               	movzbq	-0x1(%rax), %r8
               	shlq	$0x10, %r8
               	orq	%r8, %rcx
               	andq	$-0xfffff1, %rcx        # imm = 0xFF00000F
               	shlq	$0x4, %rdi
               	orq	%rdi, %rcx
               	movw	%cx, -0x3(%rax)
               	movq	%rcx, %rdi
               	shrq	$0x10, %rdi
               	movb	%dil, -0x1(%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%rdi, %rcx
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
               	addq	$0x18, %rsp
               	retq
               	movq	$-0x1, -0x10(%rax)
               	movl	$0xffffffff, -0x8(%rax) # imm = 0xFFFFFFFF
               	movw	$0xffff, -0x4(%rax)     # imm = 0xFFFF
               	movb	$-0x1, -0x2(%rax)
               	movzwq	-0x3(%rax), %rcx
               	orq	$0xff0000, %rcx         # imm = 0xFF0000
               	andq	$-0x800000, %rcx        # imm = 0xFF800000
               	orq	$0x2aaaaa, %rcx         # imm = 0x2AAAAA
               	movw	%cx, -0x3(%rax)
               	movq	%rcx, %rdi
               	shrq	$0x10, %rdi
               	movb	%dil, -0x1(%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rdi, %r8
               	shlq	$0x10, %r8
               	orq	%r8, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	cmpl	$0x2aaaaa, %ecx         # imm = 0x2AAAAA
               	jne	<addr>
               	cmpl	$0xaa, %edi
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$0x0, -0x10(%rax)
               	movq	$0x5a00, -0x8(%rax)     # imm = 0x5A00
               	movl	-0x6(%rax), %edi
               	movzwq	-0x2(%rax), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdi
               	movabsq	$-0x1000000000000, %rcx # imm = 0xFFFF000000000000
               	andq	%rdi, %rcx
               	movabsq	$0xfedcba987654, %rdi   # imm = 0xFEDCBA987654
               	orq	%rcx, %rdi
               	movl	%edi, -0x6(%rax)
               	movq	%rdi, %rcx
               	shrq	$0x20, %rcx
               	movw	%cx, -0x2(%rax)
               	movl	%edi, %edi
               	movq	%rcx, %r8
               	shlq	$0x20, %r8
               	orq	%rdi, %r8
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	cmpq	%r11, %r8
               	jne	<addr>
               	movzbq	-0x1(%rax), %r8
               	cmpl	$0xfe, %r8d
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	%rcx, %r8
               	shlq	$0x20, %r8
               	orq	%rdi, %r8
               	shrq	$0x4, %r8
               	shlq	$0x20, %rcx
               	orq	%rcx, %rdi
               	movabsq	$-0x1000000000000, %rcx # imm = 0xFFFF000000000000
               	andq	%rdi, %rcx
               	orq	%r8, %rcx
               	movl	%ecx, -0x6(%rax)
               	movq	%rcx, %rdi
               	shrq	$0x20, %rdi
               	movw	%di, -0x2(%rax)
               	movl	%ecx, %ecx
               	shlq	$0x20, %rdi
               	orq	%rdi, %rcx
               	movabsq	$0xfedcba98765, %r11    # imm = 0xFEDCBA98765
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	$-0x1, -0x20(%rax)
               	movq	$-0x1, -0x18(%rax)
               	movw	$0xffff, -0x10(%rax)    # imm = 0xFFFF
               	movb	$-0x1, -0x5(%rax)
               	movw	$0xffff, -0x4(%rax)     # imm = 0xFFFF
               	movb	$-0x1, -0x2(%rax)
               	movb	$0x3, -0xe(%rax)
               	movl	-0x5(%rax), %ecx
               	movabsq	$0xff00000000, %r11     # imm = 0xFF00000000
               	orq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	orq	%r11, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x20, %rdi
               	movl	%ecx, %r8d
               	movq	%rdi, %rcx
               	shlq	$0x20, %rcx
               	orq	%r8, %rcx
               	shlq	$0x1c, %rcx
               	orq	$0xfedcba9, %rcx        # imm = 0xFEDCBA9
               	movq	%rcx, %r9
               	sarq	$0x1c, %r9
               	shlq	$0x24, %rcx
               	movabsq	$0x876543210, %r11      # imm = 0x876543210
               	orq	%r11, %rcx
               	leaq	0x1(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	%r9, %rcx
               	movabsq	$0xfffffffff, %r9       # imm = 0xFFFFFFFFF
               	andq	%rcx, %r9
               	shlq	$0x20, %rdi
               	orq	%rdi, %r8
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%r8, %rcx
               	orq	%r9, %rcx
               	movq	%rsi, -0xd(%rax)
               	movl	%ecx, -0x5(%rax)
               	movq	%rcx, %rdi
               	shrq	$0x20, %rdi
               	movb	%dil, -0x1(%rax)
               	movl	%ecx, %ecx
               	shlq	$0x20, %rdi
               	orq	%rdi, %rcx
               	movq	%rsi, %rdi
               	shlq	$0x1c, %rdi
               	shlq	$0x1c, %rcx
               	shrq	$0x24, %rsi
               	orq	%rsi, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x1c, %rsi
               	shrq	$0x1c, %rdi
               	shlq	$0x24, %rcx
               	orq	%rcx, %rdi
               	movabsq	$-0x123456789abcdef, %rcx # imm = 0xFEDCBA9876543211
               	xorq	%rdi, %rcx
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	xorq	%r11, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0xf1, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$-0x2, %rdi
               	movl	-0x5(%rax), %esi
               	shlq	$0x20, %rcx
               	orq	%rcx, %rsi
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rsi, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdi, -0xd(%rax)
               	movl	%ecx, -0x5(%rax)
               	shrq	$0x20, %rcx
               	movb	%cl, -0x1(%rax)
               	movq	%rcx, %rsi
               	shlq	$0x20, %rsi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	orq	%r11, %rsi
               	shlq	$0x1c, %rsi
               	orq	$0xfffffff, %rsi        # imm = 0xFFFFFFF
               	movq	%rsi, %r8
               	sarq	$0x1c, %r8
               	shlq	$0x24, %rsi
               	movabsq	$0xffffffffe, %r11      # imm = 0xFFFFFFFFE
               	orq	%r11, %rsi
               	xorq	%rdi, %rsi
               	xorq	$-0x1, %r8
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpl	$0xff, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	$0x0, -0x20(%rax)
               	movq	$0x0, -0x18(%rax)
               	movl	$0x0, -0x10(%rax)
               	movw	$0x0, -0xc(%rax)
               	movb	%dl, -0xa(%rax)
               	movl	$0x0, -0x8(%rax)
               	movw	$0x0, -0x4(%rax)
               	movb	%dl, -0x2(%rax)
               	movb	$0x1, -0x9(%rax)
               	movq	-0x9(%rax), %rcx
               	andq	$0x1, %rcx
               	movabsq	$0x2468acf13579bde, %r11 # imm = 0x2468ACF13579BDE
               	orq	%r11, %rcx
               	movq	%rcx, -0x9(%rax)
               	movb	$-0x55, -0x1(%rax)
               	shrq	%rcx
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	orq	%r11, %rcx
               	movabsq	$-0x7edcba9876543211, %r11 # imm = 0x8123456789ABCDEF
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movzbq	-0x9(%rax), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
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
               	andq	$-0x2, %rsi
               	orq	%rdi, %rcx
               	movq	%rcx, -0x9(%rax)
               	movb	%sil, -0x1(%rax)
               	shrq	%rcx
               	movq	%rsi, %rdi
               	shlq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x9(%rax), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	%rsi, %rcx
               	sarq	%rcx
               	cmpl	$0x55, %ecx
               	jne	<addr>
               	cmpl	$0xaa, %esi
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x18, %rsp
               	retq
               	movzbq	-0x11(%rax), %rcx
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movb	%cl, -0x11(%rax)
               	movq	-0x11(%rax), %rcx
               	andq	$0x1, %rcx
               	movabsq	$-0x2468acf13579be0, %r11 # imm = 0xFDB97530ECA86420
               	orq	%r11, %rcx
               	movq	%rcx, -0x11(%rax)
               	shrq	%rcx
               	movabsq	$-0x8000000000000000, %rsi # imm = 0x8000000000000000
               	orq	%rcx, %rsi
               	leaq	0x1(%rsi), %rcx
               	cmpq	%rsi, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	movabsq	$0x123456789abcdef, %r11 # imm = 0x123456789ABCDEF
               	addq	%r11, %rsi
               	movq	%rcx, %r8
               	shlq	%r8
               	movq	%rsi, %rdi
               	shlq	%rdi
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rdi
               	movq	-0x11(%rax), %rcx
               	andq	$0x1, %rcx
               	orq	%r8, %rcx
               	orq	%rdi, %rdx
               	movq	%rcx, -0x11(%rax)
               	movq	%rdx, -0x9(%rax)
               	shrq	$0x3f, %rsi
               	orq	$0x54, %rsi
               	movb	%sil, -0x1(%rax)
               	movq	%rdx, %rdi
               	shrq	%rdi
               	shrq	%rcx
               	shlq	$0x3f, %rdx
               	orq	%rdx, %rcx
               	shlq	$0x3f, %rsi
               	orq	%rsi, %rdi
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	xorq	%rdi, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x11(%rax), %rcx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	movq	%rcx, %rdx
               	sarq	%rdx
               	cmpl	$0x2a, %edx
               	jne	<addr>
               	cmpl	$0x54, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	-0x11(%rax), %rdx
               	andq	$0x1, %rdx
               	orq	$-0x2, %rdx
               	movq	%rdx, -0x11(%rax)
               	movq	$-0x1, -0x9(%rax)
               	andq	$-0x2, %rcx
               	orq	$0x1, %rcx
               	movb	%cl, -0x1(%rax)
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
               	movzbq	-0x11(%rax), %rdx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	sarq	%rcx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rax
               	cmpl	$0x55, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x10, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
