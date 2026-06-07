
long_long_distinct.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x123456789abcdef, %rax # imm = 0x123456789ABCDEF
               	movabsq	$0x123456789abcdef, %r13 # imm = 0x123456789ABCDEF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %edx
               	movl	$0xc8, %eax
               	addq	%rax, %rdx
               	cmpq	$0x12c, %rdx            # imm = 0x12C
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	movl	$0xa, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	$0x14, %eax
               	movq	%rax, (%rcx)
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x10, %rcx
               	movl	$0x1e, %eax
               	movq	%rax, (%rcx)
               	leaq	-0x40(%rbp), %rcx
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addq	$0x10, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	movl	$0x64, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x60(%rbp), %rcx
               	addq	$0x8, %rcx
               	movl	$0xc8, %eax
               	movq	%rax, (%rcx)
               	leaq	-0x60(%rbp), %rcx
               	addq	$0x10, %rcx
               	movl	$0x12c, %eax            # imm = 0x12C
               	movq	%rax, (%rcx)
               	leaq	-0x60(%rbp), %rcx
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addq	$0x10, %rcx
               	movq	(%rcx), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
