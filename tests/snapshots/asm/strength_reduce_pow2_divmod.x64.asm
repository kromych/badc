
strength_reduce_pow2_divmod.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%r13, (%rsp)
               	movabsq	$-0x7, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rax, %rcx
               	sarq	$0x1, %rcx
               	cmpq	$-0x3, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x10, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rax, %rcx
               	sarq	$0x4, %rcx
               	cmpq	$-0x1, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x11, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rax, %rcx
               	sarq	$0x4, %rcx
               	cmpq	$-0x1, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rax, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0xc, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rax, %rcx
               	sarq	$0x1, %rcx
               	cmpq	$-0x40000000, %rcx      # imm = 0xC0000000
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	cmpq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movq	%rax, %rcx
               	shrq	$0x4, %rcx
               	cmpq	$0x8000000, %rcx        # imm = 0x8000000
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x12d687, %rax        # imm = 0xFFED2979
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x36, %rcx
               	addq	%rax, %rcx
               	sarq	$0xa, %rcx
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	addq	%rax, %rdx
               	sarq	$0xa, %rdx
               	cmpq	%rdx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x36, %rcx
               	addq	%rcx, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	subq	%rcx, %rax
               	movabsq	$-0x12d687, %rcx        # imm = 0xFFED2979
               	movl	$0x3ff, %edx            # imm = 0x3FF
               	addq	%rdx, %rcx
               	andq	$0x3ff, %rcx            # imm = 0x3FF
               	subq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rax, %rcx
               	sarq	$0x1, %rcx
               	movabsq	$-0x4000000000000000, %r13 # imm = 0xC000000000000000
               	movq	%rcx, %rdx
               	cmpq	%r13, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	shrq	$0x1, %rcx
               	movabsq	$0x7fffffffffffffff, %r13 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rcx, %rdx
               	cmpq	%r13, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpq	$0xff, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rax
               	cmpq	$-0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
