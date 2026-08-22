
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
               	subq	$0x600, %rsp            # imm = 0x600
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x1234, %rcx           # imm = 0x1234
               	je	<addr>
               	movl	$0xa, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x5d0(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x5, %edx
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x5d0(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x7, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x5c0(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x1, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x5c0(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x1d, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x5c0(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	je	<addr>
               	movl	$0x23, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x5b0(%rbp), %rax
               	movabsq	$-0x123456789abcdf0, %rcx # imm = 0xFEDCBA9876543210
               	movabsq	$0x123456789abcdef, %rdx # imm = 0x123456789ABCDEF
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	xorq	%rax, %rax
               	leaq	-0x5a0(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000000000, %rdx # imm = 0xF000000000000000
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x5a0(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$-0x1000000000000000, %rdx # imm = 0xF000000000000000
               	movabsq	$-0x3000000000, %r11    # imm = 0xFFFFFFD000000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	orq	$0xf000000, %rax        # imm = 0xF000000
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	movabsq	$-0x1000000000000000, %r11 # imm = 0xF000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x29, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	shlq	$0x24, %rax
               	movq	%rax, %rdx
               	sarq	$0x24, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	cmpq	$-0x3, %rdx
               	je	<addr>
               	movl	$0x2c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x5a0(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	orq	$0x0, %rax
               	movq	%rax, %rdx
               	sarq	$0x1c, %rdx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x5a0(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	shlq	$0x1c, %rax
               	orq	$0x0, %rax
               	movq	%rax, %rcx
               	sarq	$0x1c, %rcx
               	shlq	$0x24, %rax
               	orq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x32, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x590(%rbp), %rax
               	movl	$0xab, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x590(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rcx
               	movabsq	$-0x100000000000, %r11  # imm = 0xFFFFF00000000000
               	andq	%r11, %rdx
               	movq	%rcx, %rsi
               	orq	$0x300, %rsi            # imm = 0x300
               	movq	%rdx, %rcx
               	orq	$0x200000, %rcx         # imm = 0x200000
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x8, %rax
               	shlq	$0x38, %rcx
               	orq	$0x3, %rcx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x35, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x590(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0xab, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x38, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x580(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x20, %rcx
               	orq	$0x1f, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x580(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	andq	$0x1f, %rcx
               	movq	%rdx, %rsi
               	andq	$-0x2, %rsi
               	movq	%rcx, %rdx
               	orq	$0x160, %rdx            # imm = 0x160
               	orq	$0x1, %rsi
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x580(%rbp), %rcx
               	movq	%rsi, %rax
               	andq	$-0x1fffff, %rax        # imm = 0xFFE00001
               	orq	$0x1ffffe, %rax         # imm = 0x1FFFFE
               	movq	%rax, 0x8(%rcx)
               	movq	%rdx, %rcx
               	shrq	$0x5, %rcx
               	movq	%rax, %rdx
               	shlq	$0x3b, %rdx
               	orq	%rdx, %rcx
               	movabsq	$0xfffffffffffffff, %r11 # imm = 0xFFFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	movabsq	$0x80000000000000b, %r11 # imm = 0x80000000000000B
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x39, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x580(%rbp), %rcx
               	movl	(%rcx), %ecx
               	andq	$0x1f, %rcx
               	cmpq	$0x1f, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	sarq	%rax
               	andq	$0xfffff, %rax          # imm = 0xFFFFF
               	cmpq	$0xfffff, %rax          # imm = 0xFFFFF
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x1, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	addq	$0x4000000, %rdx        # imm = 0x4000000
               	addq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x1, %esi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0x4000000, %rax        # imm = 0x4000000
               	je	<addr>
               	movl	$0x3e, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x3, %esi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0xc000000, %rax        # imm = 0xC000000
               	je	<addr>
               	movl	$0x41, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	subq	$0x0, %rdx
               	subq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x2, %esi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0xc000000, %rax        # imm = 0xC000000
               	je	<addr>
               	movl	$0x44, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	shlq	$0x5, %rdx
               	orq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x40, %esi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0x180000000, %r11      # imm = 0x180000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3, %rsi
               	shlq	$0x3d, %rdx
               	orq	$0x8, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	$0x0, %rdx
               	orq	%rsi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0x8, %rdx
               	je	<addr>
               	movl	$0x49, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdi
               	xorq	%rsi, %rsi
               	orq	$0xff, %rdx
               	orq	%rsi, %rdi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	%rsi, %rdx
               	orq	%rdi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0xff, %rdx
               	je	<addr>
               	movl	$0x4c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rsi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rsi
               	andq	$-0x10, %rdx
               	andq	$-0x1, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	orq	$0x0, %rdx
               	orq	%rsi, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0xf0, %rdx
               	je	<addr>
               	movl	$0x4f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdi      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdi
               	xorq	%rsi, %rsi
               	xorq	$0x55, %rdx
               	xorq	%rsi, %rdi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdi
               	movabsq	$-0x1000000000, %r8     # imm = 0xFFFFFFF000000000
               	andq	%rcx, %r8
               	movq	%rsi, %rcx
               	orq	%rdx, %rcx
               	movq	%r8, %r14
               	orq	%rdi, %r14
               	movq	%rcx, (%rax)
               	movq	%r14, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%r14, %rax
               	cmpq	$0xa5, %rcx
               	je	<addr>
               	movl	$0x52, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %r13
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%r14, %rdx
               	xorq	%r15, %r15
               	movq	%rcx, %rax
               	xorq	%r15, %rax
               	movq	%rdx, %rcx
               	xorq	%r15, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rax
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movl	$0x7, %r9d
               	movq	%rcx, %rax
               	orq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r8
               	shrq	$0x3f, %r8
               	movq	%rsi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%rbx, %rsi
               	orq	%r8, %rsi
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x7, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r8
               	orq	%r8, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r8, %r8
               	subq	%rdi, %r8
               	andq	%r9, %r8
               	cmpq	%r8, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r8, %rsi
               	subq	$0x0, %rax
               	subq	%r12, %rax
               	orq	%rbx, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	xorq	%rdx, %rdi
               	xorq	%rdx, %rcx
               	testq	%rdi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	$0x0, %rdi
               	subq	$0x0, %rcx
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rdx, %rax
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	andq	%r14, %rdx
               	movq	%rdi, %rcx
               	orq	$0x0, %rcx
               	movq	%rdx, %r14
               	orq	%rax, %r14
               	movq	%rcx, (%r13)
               	movq	%r14, 0x8(%r13)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%r14, %rax
               	movabsq	$-0x249249249249247b, %r11 # imm = 0xDB6DB6DB6DB6DB85
               	movq	%rcx, %rdx
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x55, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %r13
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%r14, %rdx
               	xorq	%r15, %r15
               	movq	%rcx, %rax
               	xorq	%r15, %rax
               	movq	%rdx, %rcx
               	xorq	%r15, %rcx
               	testq	%rax, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	leaq	(%rax), %rsi
               	leaq	(%rcx), %rax
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movl	$0xf4243, %r8d          # imm = 0xF4243
               	movq	%rcx, %rax
               	orq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movl	$0x80, %edx
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rcx, %r9
               	shrq	$0x3f, %r9
               	movq	%rsi, %rbx
               	shlq	%rbx
               	shlq	%rax
               	shrq	$0x3f, %rsi
               	orq	%rsi, %rax
               	movq	%rbx, %rsi
               	orq	%r9, %rsi
               	movq	%rdi, %rbx
               	shlq	%rbx
               	shlq	%rcx
               	shrq	$0x3f, %rdi
               	orq	%rdi, %rcx
               	testq	%rax, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	testq	%rax, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r8, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r9
               	orq	%r9, %rdi
               	xorq	$0x1, %rdi
               	xorq	%r9, %r9
               	subq	%rdi, %r9
               	andq	%r8, %r9
               	cmpq	%r9, %rsi
               	setb	%r12b
               	movzbq	%r12b, %r12
               	subq	%r9, %rsi
               	subq	$0x0, %rax
               	subq	%r12, %rax
               	orq	%rbx, %rdi
               	decq	%rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rcx
               	xorq	%r15, %rcx
               	xorq	%r15, %rax
               	testq	%rcx, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	subq	$0x0, %rcx
               	subq	$0x0, %rax
               	subq	%rdx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rax
               	movabsq	$-0x1000000000, %rsi    # imm = 0xFFFFFFF000000000
               	andq	%r14, %rsi
               	movq	%rcx, %rdx
               	orq	$0x0, %rdx
               	movq	%rsi, %rcx
               	orq	%rax, %rcx
               	movq	%rdx, (%r13)
               	movq	%rcx, 0x8(%r13)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	cmpq	$0x247c3, %rdx          # imm = 0x247C3
               	je	<addr>
               	movl	$0x58, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x1, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	addq	$0x0, %rdx
               	incq	%rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	xorq	%rsi, %rsi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5c, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	decq	%rdx
               	addq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movabsq	$-0x1, %rsi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5f, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x5, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	leaq	(%rdx), %rsi
               	addq	$0x0, %rsi
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rsi
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x6, %edi
               	orq	%rsi, %rcx
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x62, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x570(%rbp), %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x5, %edx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x570(%rbp), %rax
               	movabsq	$0xfffffffff, %rdx      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rdx
               	addq	$0x0, %rdx
               	addq	$0x0, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	movl	$0x6, %esi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x68, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x560(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	orq	$0x0, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x560(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	movabsq	$0x3e8000000000, %r11   # imm = 0x3E8000000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x560(%rbp), %rax
               	movq	%rcx, %rdx
               	shrq	$0x24, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	addq	$0x7, %rdx
               	andq	$0xfffffff, %rdx        # imm = 0xFFFFFFF
               	shlq	$0x24, %rdx
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	xorq	%rsi, %rsi
               	orq	%rdx, %rcx
               	movq	%rsi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x3ef, %rax            # imm = 0x3EF
               	je	<addr>
               	movl	$0x6c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x560(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rcx
               	xorq	%rdx, %rdx
               	movabsq	$0x3f0000000000, %r11   # imm = 0x3F0000000000
               	orq	%r11, %rcx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	cmpq	$0x3f0, %rax            # imm = 0x3F0
               	je	<addr>
               	movl	$0x6d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	leaq	-0x550(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	andq	%r11, %rdx
               	xorq	%rsi, %rsi
               	orq	$0x0, %rdx
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x550(%rbp), %rax
               	movabsq	$0xfffffffff, %r11      # imm = 0xFFFFFFFFF
               	andq	%r11, %rdx
               	xorq	%rsi, %rsi
               	movabsq	$-0x5000000000, %r11    # imm = 0xFFFFFFB000000000
               	orq	%r11, %rdx
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rdx, %rax
               	shrq	$0x24, %rax
               	andq	$0xfffffff, %rax        # imm = 0xFFFFFFF
               	shlq	$0x24, %rax
               	movq	%rax, %rsi
               	sarq	$0x24, %rsi
               	cmpq	$-0x5, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	movabsq	$0xfffffffff, %rax      # imm = 0xFFFFFFFFF
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x70, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x600, %rsp            # imm = 0x600
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x59, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r8
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	cmpq	$0x6db6db6, %rax        # imm = 0x6DB6DB6
               	je	<addr>
               	movl	$0x56, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	pushq	%rax
               	pushq	%rdx
               	movq	%rsi, %rax
               	xorq	%rdx, %rdx
               	divq	%r9
               	movq	%rdx, %rsi
               	popq	%rdx
               	popq	%rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	cmpq	$0x30000000, %rax       # imm = 0x30000000
               	je	<addr>
               	movl	$0x53, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$0x30000000, %rax       # imm = 0x30000000
               	je	<addr>
               	movl	$0x50, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$0x30000000, %rax       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4d, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$0x30000000, %rax       # imm = 0x30000000
               	je	<addr>
               	movl	$0x4a, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	cmpq	$0x2000, %rax           # imm = 0x2000
               	je	<addr>
               	movl	$0x36, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$0x400000000, %r11      # imm = 0x400000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x33, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$-0x800000000, %r11     # imm = 0xFFFFFFF800000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x30, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rsi
               	je	<addr>
               	movl	$0x2d, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	cmpq	$-0x1, %rdx
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movabsq	$0x800000000, %r11      # imm = 0x800000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
