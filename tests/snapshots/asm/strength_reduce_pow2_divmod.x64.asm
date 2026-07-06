
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
               	subq	$0xa0, %rsp
               	movabsq	$-0x7, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	$0x1, %rax
               	cmpq	$-0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x10, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	sarq	$0x4, %rax
               	cmpq	$-0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x11, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	sarq	$0x4, %rax
               	cmpq	$-0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3c, %rcx
               	addq	%rcx, %rax
               	andq	$0xf, %rax
               	subq	%rcx, %rax
               	cmpq	$-0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	sarq	$0x3, %rax
               	cmpq	$0xc, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rcx, %rax
               	andq	$0x7, %rax
               	subq	%rcx, %rax
               	cmpq	$0x4, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	$0x1, %rax
               	cmpq	$-0x40000000, %rax      # imm = 0xC0000000
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	shrq	$0x1, %rax
               	cmpq	$0x7fffffff, %rax       # imm = 0x7FFFFFFF
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	movl	%eax, -0x10(%rbp)
               	movl	-0x10(%rbp), %eax
               	shrq	$0x4, %rax
               	cmpq	$0x8000000, %rax        # imm = 0x8000000
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x12d687, %rax        # imm = 0xFFED2979
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x36, %rcx
               	addq	%rcx, %rax
               	sarq	$0xa, %rax
               	cmpq	$-0x4b5, %rax           # imm = 0xFB4B
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x36, %rcx
               	addq	%rcx, %rax
               	andq	$0x3ff, %rax            # imm = 0x3FF
               	subq	%rcx, %rax
               	cmpq	$-0x287, %rax           # imm = 0xFD79
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movq	%rax, -0x38(%rbp)
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	$0x1, %rax
               	movabsq	$-0x4000000000000000, %r11 # imm = 0xC000000000000000
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x38(%rbp), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	andq	$0x1, %rax
               	subq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movq	%rax, -0x40(%rbp)
               	movq	-0x40(%rbp), %rax
               	shrq	$0x1, %rax
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x40(%rbp), %rax
               	andq	$0xff, %rax
               	cmpq	$0xff, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x5, %rax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$-0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
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
