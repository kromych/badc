
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
               	movl	$0xffffffff, -0x8(%rax) # imm = 0xFFFFFFFF
               	movw	$0xffff, -0x4(%rax)     # imm = 0xFFFF
               	movb	$-0x1, -0x2(%rax)
               	movzwq	-0x3(%rax), %rdx
               	orq	$0xff0000, %rdx         # imm = 0xFF0000
               	andq	$-0x400000, %rdx        # imm = 0xFFC00000
               	orq	$0x3ffffb, %rdx         # imm = 0x3FFFFB
               	movq	%rdx, %rsi
               	shrq	$0x10, %rsi
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rdi
               	shlq	$0x10, %rdi
               	orq	%rdx, %rdi
               	shlq	$0x2a, %rdi
               	sarq	$0x2a, %rdi
               	addq	$0x7, %rdi
               	andq	$0x3fffff, %rdi         # imm = 0x3FFFFF
               	shlq	$0x10, %rsi
               	orq	%rsi, %rdx
               	andq	$-0x400000, %rdx        # imm = 0xFFC00000
               	orq	%rdi, %rdx
               	movw	%dx, -0x3(%rax)
               	movq	%rdx, %rsi
               	shrq	$0x10, %rsi
               	movb	%sil, -0x1(%rax)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movq	%rsi, %rdi
               	shlq	$0x10, %rdi
               	orq	%rdi, %rdx
               	shlq	$0x2a, %rdx
               	sarq	$0x2a, %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	cmpl	$0xc0, %esi
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movb	$-0x1, -0x3(%rax)
               	movb	$-0x1, -0x2(%rax)
               	movl	-0x5(%rax), %edx
               	movabsq	$0xff00000000, %r11     # imm = 0xFF00000000
               	orq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	movabsq	$0xedcba9877, %rsi      # imm = 0xEDCBA9877
               	orq	%rdx, %rsi
               	movl	%esi, -0x5(%rax)
               	movq	%rsi, %rdx
               	shrq	$0x20, %rdx
               	movb	%dl, -0x1(%rax)
               	movl	%esi, %esi
               	movq	%rdx, %rdi
               	shlq	$0x20, %rdi
               	orq	%rsi, %rdi
               	shlq	$0x1c, %rdi
               	sarq	$0x1c, %rdi
               	movabsq	$-0x123456789, %r11     # imm = 0xFFFFFFFEDCBA9877
               	cmpq	%r11, %rdi
               	jne	<addr>
               	cmpl	$0xfe, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	shlq	$0x20, %rdx
               	orq	%rsi, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	orq	$0x5, %rdx
               	movl	%edx, -0x5(%rax)
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	movb	%sil, -0x1(%rax)
               	movl	%edx, %edx
               	movq	%rsi, %rdi
               	shlq	$0x20, %rdi
               	orq	%rdi, %rdx
               	shlq	$0x1c, %rdx
               	sarq	$0x1c, %rdx
               	cmpq	$0x5, %rdx
               	jne	<addr>
               	cmpl	$0xf0, %esi
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movb	$-0x1, -0x5(%rax)
               	movl	$0xffffffff, -0x4(%rax) # imm = 0xFFFFFFFF
               	movl	-0x6(%rax), %edx
               	movzwq	-0x2(%rax), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rdx
               	movabsq	$0x7ffffffffff, %r11    # imm = 0x7FFFFFFFFFF
               	orq	%r11, %rdx
               	shrq	$0x20, %rdx
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	movq	%rdx, %rdi
               	shlq	$0x20, %rdi
               	orq	%rsi, %rdi
               	shlq	$0x14, %rdi
               	sarq	$0x14, %rdi
               	decq	%rdi
               	movabsq	$0xfffffffffff, %r11    # imm = 0xFFFFFFFFFFF
               	andq	%r11, %rdi
               	shlq	$0x20, %rdx
               	orq	%rsi, %rdx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rdx
               	orq	%rdi, %rdx
               	movl	%edx, -0x6(%rax)
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	movw	%si, -0x2(%rax)
               	movl	%edx, %edx
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	shlq	$0x14, %rdx
               	sarq	$0x14, %rdx
               	movabsq	$0x7fffffffffe, %r11    # imm = 0x7FFFFFFFFFE
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rdx
               	cmpl	$0xf7, %edx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movw	$0xffff, -0x6(%rax)     # imm = 0xFFFF
               	movw	$0xffff, -0x4(%rax)     # imm = 0xFFFF
               	movb	$-0x1, -0x2(%rax)
               	movl	-0x7(%rax), %edx
               	movzwq	-0x3(%rax), %rsi
               	shlq	$0x20, %rsi
               	orq	%rsi, %rdx
               	movabsq	$0xff000000000000, %r11 # imm = 0xFF000000000000
               	orq	%r11, %rdx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rdx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	orq	%r11, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x20, %rdi
               	shrq	$0x30, %rdx
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rdi, %r8
               	shlq	$0x20, %r8
               	orq	%rsi, %r8
               	movq	%rdx, %r9
               	shlq	$0x30, %r9
               	orq	%r9, %r8
               	shlq	$0xc, %r8
               	sarq	$0xc, %r8
               	xorq	$0x5, %r8
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %r8
               	shlq	$0x20, %rdi
               	orq	%rdi, %rsi
               	shlq	$0x30, %rdx
               	orq	%rsi, %rdx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rdx
               	orq	%r8, %rdx
               	movl	%edx, -0x7(%rax)
               	movq	%rdx, %rdi
               	shrq	$0x20, %rdi
               	movw	%di, -0x3(%rax)
               	movq	%rdx, %rsi
               	shrq	$0x30, %rsi
               	movb	%sil, -0x1(%rax)
               	movl	%edx, %edx
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rdi, %r8
               	shlq	$0x20, %r8
               	orq	%rdx, %r8
               	movq	%rsi, %r9
               	shlq	$0x30, %r9
               	orq	%r9, %r8
               	shlq	$0xc, %r8
               	sarq	$0xc, %r8
               	cmpq	$-0x6, %r8
               	jne	<addr>
               	cmpl	$0xff, %esi
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	shlq	$0x20, %rdi
               	orq	%rdi, %rdx
               	movzbq	-0x1(%rax), %rsi
               	shlq	$0x30, %rsi
               	orq	%rsi, %rdx
               	movabsq	$-0x10000000000000, %r11 # imm = 0xFFF0000000000000
               	andq	%r11, %rdx
               	movl	%edx, -0x7(%rax)
               	movq	%rdx, %rdi
               	shrq	$0x20, %rdi
               	movw	%di, -0x3(%rax)
               	movq	%rdx, %rsi
               	shrq	$0x30, %rsi
               	movb	%sil, -0x1(%rax)
               	movl	%edx, %edx
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	shlq	$0x20, %rdi
               	orq	%rdi, %rdx
               	movq	%rsi, %rdi
               	shlq	$0x30, %rdi
               	orq	%rdi, %rdx
               	shlq	$0xc, %rdx
               	sarq	$0xc, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpl	$0xf0, %esi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	$0x0, -0x10(%rax)
               	movl	$0x0, -0x8(%rax)
               	movb	%dl, -0x4(%rax)
               	movb	%dl, -0x2(%rax)
               	movb	$0x9, -0x3(%rax)
               	movzwq	-0x3(%rax), %rsi
               	andq	$-0xfffff1, %rsi        # imm = 0xFF00000F
               	orq	$0xedcbb0, %rsi         # imm = 0xEDCBB0
               	movw	%si, -0x3(%rax)
               	movq	%rsi, %rdi
               	shrq	$0x10, %rdi
               	movb	%dil, -0x1(%rax)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rdi, %r8
               	shlq	$0x10, %r8
               	orq	%rsi, %r8
               	sarq	$0x4, %r8
               	shlq	$0x2c, %r8
               	sarq	$0x2c, %r8
               	cmpl	$0xfffedcbb, %r8d       # imm = 0xFFFEDCBB
               	jne	<addr>
               	movzbq	-0x3(%rax), %r8
               	andq	$0xf, %r8
               	cmpl	$0x9, %r8d
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	shlq	$0x10, %rdi
               	orq	%rdi, %rsi
               	sarq	$0x4, %rsi
               	shlq	$0x2c, %rsi
               	sarq	$0x2c, %rsi
               	incq	%rsi
               	andq	$0xfffff, %rsi          # imm = 0xFFFFF
               	movzwq	-0x3(%rax), %rdi
               	movzbq	-0x1(%rax), %r8
               	shlq	$0x10, %r8
               	orq	%r8, %rdi
               	andq	$-0xfffff1, %rdi        # imm = 0xFF00000F
               	shlq	$0x4, %rsi
               	orq	%rdi, %rsi
               	movw	%si, -0x3(%rax)
               	movq	%rsi, %rdi
               	shrq	$0x10, %rdi
               	movb	%dil, -0x1(%rax)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	shlq	$0x10, %rdi
               	orq	%rdi, %rsi
               	sarq	$0x4, %rsi
               	shlq	$0x2c, %rsi
               	sarq	$0x2c, %rsi
               	cmpl	$0xfffedcbc, %esi       # imm = 0xFFFEDCBC
               	jne	<addr>
               	movzbq	-0x3(%rax), %rsi
               	andq	$0xf, %rsi
               	cmpl	$0x9, %esi
               	je	<addr>
               	movl	$0xa, %eax
               	leave
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
               	movq	%rcx, %rsi
               	shrq	$0x10, %rsi
               	movb	%sil, -0x1(%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movq	%rsi, %rdi
               	shlq	$0x10, %rdi
               	orq	%rdi, %rcx
               	andq	$0x7fffff, %rcx         # imm = 0x7FFFFF
               	cmpl	$0x2aaaaa, %ecx         # imm = 0x2AAAAA
               	jne	<addr>
               	cmpl	$0xaa, %esi
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
               	movabsq	$0xfedcba987654, %rsi   # imm = 0xFEDCBA987654
               	orq	%rcx, %rsi
               	movl	%esi, -0x6(%rax)
               	movq	%rsi, %rcx
               	shrq	$0x20, %rcx
               	movw	%cx, -0x2(%rax)
               	movl	%esi, %esi
               	movq	%rcx, %rdi
               	shlq	$0x20, %rdi
               	orq	%rsi, %rdi
               	movabsq	$0xfedcba987654, %r11   # imm = 0xFEDCBA987654
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movzbq	-0x1(%rax), %rdi
               	cmpl	$0xfe, %edi
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	%rcx, %rdi
               	shlq	$0x20, %rdi
               	orq	%rsi, %rdi
               	shrq	$0x4, %rdi
               	shlq	$0x20, %rcx
               	orq	%rsi, %rcx
               	movabsq	$-0x1000000000000, %r11 # imm = 0xFFFF000000000000
               	andq	%r11, %rcx
               	orq	%rdi, %rcx
               	movl	%ecx, -0x6(%rax)
               	movq	%rcx, %rsi
               	shrq	$0x20, %rsi
               	movw	%si, -0x2(%rax)
               	movl	%ecx, %ecx
               	shlq	$0x20, %rsi
               	orq	%rsi, %rcx
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
               	movq	%rcx, %rsi
               	shrq	$0x20, %rsi
               	movl	%ecx, %edi
               	movq	%rsi, %rcx
               	shlq	$0x20, %rcx
               	orq	%rdi, %rcx
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
               	shlq	$0x20, %rsi
               	orq	%rdi, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rsi
               	orq	%r8, %rsi
               	movq	%rcx, -0xd(%rax)
               	movl	%esi, -0x5(%rax)
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movb	%dil, -0x1(%rax)
               	movl	%esi, %esi
               	shlq	$0x20, %rdi
               	orq	%rdi, %rsi
               	movq	%rcx, %rdi
               	shlq	$0x1c, %rdi
               	shlq	$0x1c, %rsi
               	shrq	$0x24, %rcx
               	orq	%rsi, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x1c, %rsi
               	shrq	$0x1c, %rdi
               	shlq	$0x24, %rcx
               	orq	%rdi, %rcx
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789, %r11      # imm = 0x123456789
               	xorq	%r11, %rsi
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	-0x1(%rax), %rcx
               	cmpl	$0xf1, %ecx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	movq	$-0x2, %rsi
               	movl	-0x5(%rax), %edi
               	shlq	$0x20, %rcx
               	orq	%rdi, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rsi, -0xd(%rax)
               	movl	%ecx, -0x5(%rax)
               	shrq	$0x20, %rcx
               	movb	%cl, -0x1(%rax)
               	movq	%rcx, %rdi
               	shlq	$0x20, %rdi
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	orq	%r11, %rdi
               	shlq	$0x1c, %rdi
               	orq	$0xfffffff, %rdi        # imm = 0xFFFFFFF
               	movq	%rdi, %r8
               	sarq	$0x1c, %r8
               	shlq	$0x24, %rdi
               	movabsq	$0xffffffffe, %r11      # imm = 0xFFFFFFFFE
               	orq	%r11, %rdi
               	xorq	%rdi, %rsi
               	xorq	$-0x1, %r8
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpl	$0xff, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
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
               	movq	%rcx, %r8
               	andq	$0x1, %r8
               	movq	%rsi, %rcx
               	andq	$-0x2, %rcx
               	movq	%r8, %rsi
               	orq	%rdi, %rsi
               	movq	%rsi, -0x9(%rax)
               	movb	%cl, -0x1(%rax)
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
               	movq	%rcx, %rdi
               	shlq	%rdi
               	movq	%rsi, %r8
               	shlq	%r8
               	shrq	$0x3f, %rcx
               	orq	%rcx, %r8
               	movq	-0x11(%rax), %rcx
               	andq	$0x1, %rcx
               	orq	%rdi, %rcx
               	orq	%r8, %rdx
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
               	orq	%rdi, %rsi
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	xorq	%r11, %rcx
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	xorq	%rsi, %rdx
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
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x10, %eax
               	leave
               	retq
               	movl	$0xd, %eax
               	leave
               	retq
