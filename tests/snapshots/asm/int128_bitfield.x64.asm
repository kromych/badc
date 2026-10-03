
int128_bitfield.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x1234, %rcx           # imm = 0x1234
               	je	<addr>
               	movl	$0xa, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	0x8(%rcx), %rax
               	shrq	$0x24, %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$0x800000000, %rcx      # imm = 0x800000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	cmpl	$0xfffffff, %eax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x1d, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	cmpl	$0xfffffff, %eax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x23, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x3000000000, %rcx    # imm = 0xFFFFFFD000000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	orq	$0xf000000, %rax        # imm = 0xF000000
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	shlq	$0x24, %rax
               	sarq	$0x24, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x2c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movabsq	$0x800000000, %rcx      # imm = 0x800000000
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1c, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movb	$-0x55, (%rcx)
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	andq	$0xff, %rax
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rdx
               	movq	%rax, %rsi
               	orq	$0x300, %rsi            # imm = 0x300
               	movq	%rdx, %rax
               	orq	$0x200000, %rax         # imm = 0x200000
               	movq	%rsi, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, %rdx
               	shrq	$0x8, %rdx
               	shlq	$0x38, %rax
               	orq	$0x3, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movzbq	(%rcx), %rax
               	xorq	$0xab, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x38, %eax
               	leave
               	retq
               	leaq	-0x20(%rbp), %rcx
               	movl	(%rcx), %eax
               	andq	$-0x20, %rax
               	orq	$0x1f, %rax
               	movl	%eax, (%rcx)
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	andq	$0x1f, %rax
               	andq	$-0x2, %rdx
               	orq	$0x160, %rax            # imm = 0x160
               	orq	$0x1, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	andq	$-0x1fffff, %rdx        # imm = 0xFFE00001
               	orq	$0x1ffffe, %rdx         # imm = 0x1FFFFE
               	movq	%rdx, 0x8(%rcx)
               	shrq	$0x5, %rax
               	movq	%rdx, %rsi
               	shlq	$0x3b, %rsi
               	orq	%rsi, %rax
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x80000000000000b, %r11 # imm = 0x80000000000000B
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x39, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	(%rcx), %eax
               	andq	$0x1f, %rax
               	cmpl	$0x1f, %eax
               	jne	<addr>
               	movq	%rdx, %rax
               	sarq	%rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpl	$0xfffff, %eax          # imm = 0xFFFFF
               	je	<addr>
               	movl	$0x3c, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	addq	$0x4000000, %rcx        # imm = 0x4000000
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	cmpq	$0x4000000, %rdx        # imm = 0x4000000
               	je	<addr>
               	movl	$0x3e, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	(%rdx,%rdx,2), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	cmpq	$0xc000000, %rdx        # imm = 0xC000000
               	je	<addr>
               	movl	$0x41, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movq	%rax, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	cmpq	$0xc000000, %rdx        # imm = 0xC000000
               	je	<addr>
               	movl	$0x44, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	%rdx, %rax
               	shlq	$0x5, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	movabsq	$0x180000000, %r11      # imm = 0x180000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x47, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	%rdx, %rax
               	shrq	$0x3, %rax
               	shlq	$0x3d, %rdx
               	orq	$0x8, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x49, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	orq	$0xff, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rax, %rdi
               	orq	%rdx, %rdi
               	movq	%rcx, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rsi
               	cmpq	$0xff, %rdi
               	je	<addr>
               	movl	$0x4c, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	andq	$-0x10, %rdi
               	movabsq	$-0x1000000000, %rcx    # imm = 0xFFFFFFF000000000
               	andq	%rdx, %rcx
               	movq	%rcx, %rdx
               	orq	%rsi, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %r8       # imm = 0xFFFFFFFFF
               	andq	%rdx, %r8
               	cmpq	$0xf0, %rdi
               	je	<addr>
               	movl	$0x4f, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	%rdi, %rcx
               	xorq	$0x55, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	movq	%rdx, %r9
               	orq	%r8, %r9
               	movq	%r9, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%r9, %rcx
               	cmpq	$0xa5, %rsi
               	je	<addr>
               	movl	$0x52, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x7, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	xorl	%edi, %edi
               	cmpq	$0x7, %rcx
               	jb	<addr>
               	movabsq	$0x2492492492492493, %r8 # imm = 0x2492492492492493
               	pushq	%rax
               	movq	%rcx, %rax
               	mulq	%r8
               	movq	%rdx, %r8
               	popq	%rax
               	imulq	$0x7, %r8, %rdx
               	subq	%rdx, %rcx
               	movq	%rax, %r11
               	pushq	%rax
               	movq	%rcx, %rdx
               	movq	%rsi, %rax
               	divq	%r11
               	movq	%rax, %rcx
               	popq	%rax
               	movq	%rcx, %rdx
               	imulq	%rax, %rdx
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%r9, %rax
               	orq	%rax, %r8
               	movq	%r8, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%r8, %rsi
               	movabsq	$-0x249249249249247b, %r11 # imm = 0xDB6DB6DB6DB6DB85
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x55, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0xf4243, %r9d          # imm = 0xF4243
               	testq	%rsi, %rsi
               	je	<addr>
               	xorl	%edi, %edi
               	cmpq	%r9, %rsi
               	jb	<addr>
               	movabsq	$0x10c6f45449cc, %rax   # imm = 0x10C6F45449CC
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	mulq	%r10
               	imulq	$0xf4243, %rdx, %rax    # imm = 0xF4243
               	subq	%rax, %rsi
               	pushq	%rdx
               	movq	%rsi, %rdx
               	movq	%rcx, %rax
               	divq	%r9
               	popq	%rdx
               	movq	%rax, %rsi
               	imulq	%r9, %rsi
               	subq	%rsi, %rcx
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%r8, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	cmpq	$0x247c3, %rcx          # imm = 0x247C3
               	je	<addr>
               	movl	$0x58, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rdx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	incq	%rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	decq	%rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rax, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rax, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x62, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movabsq	$-0x1000000000, %rax    # imm = 0xFFFFFFF000000000
               	andq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %rcx      # imm = 0xFFFFFFFFF
               	andq	%rax, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x68, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x3e8000000000, %r11   # imm = 0x3E8000000000
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	cmpl	$0x3e8, %ecx            # imm = 0x3E8
               	jne	<addr>
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x3ef000000000, %r11   # imm = 0x3EF000000000
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	cmpl	$0x3ef, %ecx            # imm = 0x3EF
               	je	<addr>
               	movl	$0x6c, %eax
               	leave
               	retq
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$0x3f0000000000, %r11   # imm = 0x3F0000000000
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	cmpl	$0x3f0, %ecx            # imm = 0x3F0
               	je	<addr>
               	movl	$0x6d, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x5000000000, %r11    # imm = 0xFFFFFFB000000000
               	orq	%r11, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	shlq	$0x24, %rdx
               	sarq	$0x24, %rdx
               	cmpl	$-0x5, %edx
               	jne	<addr>
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x70, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x1(%rax), %edx
               	movzbq	0x5(%rax), %rax
               	shlq	$0x20, %rax
               	orq	%rdx, %rax
               	shlq	$0x18, %rax
               	sarq	$0x18, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x79, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rax)
               	movzwq	0x4(%rdx), %r10
               	movw	%r10w, 0x4(%rax)
               	movzbq	0x6(%rdx), %r10
               	movb	%r10b, 0x6(%rax)
               	movl	$0xffffffff, 0x1(%rax)  # imm = 0xFFFFFFFF
               	movb	$0x7f, 0x5(%rax)
               	movl	$0x0, 0x1(%rax)
               	movb	$-0x80, 0x5(%rax)
               	movl	$0x1, 0x1(%rax)
               	movb	$-0x80, 0x5(%rax)
               	movl	$0xfffffffe, 0x1(%rax)  # imm = 0xFFFFFFFE
               	movb	$-0x1, 0x5(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	shlq	$0x24, %rcx
               	sarq	$0x24, %rcx
               	movl	%ecx, %ecx
               	movl	$0xba2e8ba3, %r11d      # imm = 0xBA2E8BA3
               	imulq	%r11, %rcx
               	shrq	$0x23, %rcx
               	andq	$0xfffffff, %rcx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	shlq	$0x24, %rcx
               	sarq	$0x24, %rcx
               	cmpl	$0x745d174, %ecx        # imm = 0x745D174
               	je	<addr>
               	movl	$0x8f, %eax
               	leave
               	retq
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	orq	%r11, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	shlq	$0x24, %rcx
               	sarq	$0x24, %rcx
               	movl	%ecx, %ecx
               	movl	$0xba2e8ba3, %edx       # imm = 0xBA2E8BA3
               	imulq	%rcx, %rdx
               	shrq	$0x23, %rdx
               	imulq	$0xb, %rdx, %rdx
               	subq	%rdx, %rcx
               	shlq	$0x24, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	orq	%rcx, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rax, %rcx
               	shrq	$0x24, %rcx
               	shlq	$0x24, %rcx
               	sarq	$0x24, %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	shlq	$0x1c, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x90, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x91, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x92, %eax
               	jmp	<addr>
               	cmpl	$-0x1, %edx
               	je	<addr>
               	movl	$0x7a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x6e, %eax
               	leave
               	retq
               	movl	$0x6b, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x59, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movabsq	$0xc6f45449cb59c69, %rsi # imm = 0xC6F45449CB59C69
               	movq	%rcx, %rax
               	mulq	%rsi
               	movq	%rcx, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	shrq	$0x13, %rax
               	imulq	$0xf4243, %rax, %rdx    # imm = 0xF4243
               	subq	%rdx, %rcx
               	xorl	%edi, %edi
               	movq	%rdi, %rdx
               	jmp	<addr>
               	cmpq	$0x6db6db6, %rsi        # imm = 0x6DB6DB6
               	je	<addr>
               	movl	$0x56, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rdi, %r8
               	jmp	<addr>
               	movabsq	$0x2492492492492493, %rcx # imm = 0x2492492492492493
               	movq	%rsi, %rax
               	mulq	%rcx
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	movq	%rax, %rcx
               	shrq	$0x2, %rcx
               	imulq	$0x7, %rcx, %rdx
               	movq	%rsi, %rax
               	subq	%rdx, %rax
               	xorl	%edi, %edi
               	movq	%rdi, %r8
               	jmp	<addr>
               	cmpq	$0x30000000, %rcx       # imm = 0x30000000
               	je	<addr>
               	movl	$0x53, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpq	$0x30000000, %r8        # imm = 0x30000000
               	je	<addr>
               	movl	$0x50, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	cmpq	$0x30000000, %rsi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4d, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	cmpq	$0x30000000, %rsi       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpq	$0x2000, %rdx           # imm = 0x2000
               	je	<addr>
               	movl	$0x36, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x33, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$-0x800000000, %r11     # imm = 0xFFFFFFF800000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x30, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpl	$-0x1, %edx
               	je	<addr>
               	movl	$0x2d, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
