
strength_reduce_pow2_divmod.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpq	$-0x3, %rax
               	jne	<addr>
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$-0x10, %rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	sarq	$0x4, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$-0x11, %rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	sarq	$0x4, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x64, %eax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpq	$-0x40000000, %rax      # imm = 0xC0000000
               	jne	<addr>
               	movslq	-0x20(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x18(%rbp)
               	movl	-0x18(%rbp), %eax
               	shrq	%rax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	%eax, -0x18(%rbp)
               	movl	-0x18(%rbp), %eax
               	shrq	$0x4, %rax
               	cmpq	$0x8000000, %rax        # imm = 0x8000000
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$-0x12d687, %rax        # imm = 0xFFED2979
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x36, %rcx
               	addq	%rcx, %rax
               	sarq	$0xa, %rax
               	cmpq	$-0x4b5, %rax           # imm = 0xFB4B
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x36, %rcx
               	addq	%rcx, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	subq	%rcx, %rax
               	cmpq	$-0x287, %rax           # imm = 0xFD79
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movabsq	$-0x4000000000000000, %r11 # imm = 0xC000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shrq	%rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	andq	$0xff, %rax
               	cmpl	$0xff, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movabsq	$-0x5, %rax
               	movl	%eax, -0x20(%rbp)
               	movslq	-0x20(%rbp), %rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movslq	-0x20(%rbp), %rax
               	xorq	%rax, %rax
               	leave
               	retq
               	movl	$0xb, %eax
               	leave
               	retq
