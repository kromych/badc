
setjmp_longjmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%esi, %rsi
               	movq	%rdi, %r8
               	addq	$0x200, %r8             # imm = 0x200
               	movl	%esi, (%r8)
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x240, %rsp            # imm = 0x240
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	jmp	<addr>
               	movl	$0xb, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	leaq	-0x208(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movslq	%r12d, %r8
               	cmpq	$0x0, %r8
               	jne	<addr>
               	leaq	-0x208(%rbp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	movslq	%r12d, %r12
               	cmpq	$0x7, %r12
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	cmpq	$0x1, %rbx
               	je	<addr>
               	movl	$0xe, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %rbx
               	addq	$0x200, %rbx            # imm = 0x200
               	movslq	(%rbx), %rbx
               	cmpq	$0x7, %rbx
               	je	<addr>
               	movl	$0xf, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x240, %rsp            # imm = 0x240
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
