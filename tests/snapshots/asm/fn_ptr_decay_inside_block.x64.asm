
fn_ptr_decay_inside_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	addq	$0x64, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	$0x1, %r9d
               	movslq	%r9d, %r9
               	cmpq	$0x0, %r9
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %r12       # <addr>
               	movq	%r12, -0x30(%rbp)
               	jmp	<addr>
               	leaq	-<rip>, %rbx       # <addr>
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r14
               	movl	$0x1, %r15d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	callq	*%r11
               	addq	%rax, %r14
               	movl	%r14d, (%r12)
               	leaq	-0x8(%rbp), %r15
               	movslq	(%r15), %r12
               	movl	$0x2, %r14d
               	movq	%rbx, %r11
               	movq	%r14, %rdi
               	callq	*%r11
               	addq	%rax, %r12
               	movl	%r12d, (%r15)
               	jmp	<addr>
               	movq	-0x30(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, -0x30(%rbp)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rbx
               	movslq	(%rbx), %r14
               	movl	$0x3, %r12d
               	movq	-0x30(%rbp), %r15
               	movq	%r15, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	addq	%rax, %r14
               	movl	%r14d, (%rbx)
               	jmp	<addr>
               	leaq	-<rip>, %r14      # <addr>
               	movq	%r14, -0x48(%rbp)
               	leaq	-0x8(%rbp), %r12
               	movslq	(%r12), %r15
               	leaq	-0x48(%rbp), %rbx
               	movq	(%rbx), %r14
               	movl	$0x4, %ebx
               	movq	%r14, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	addq	%rax, %r15
               	movl	%r15d, (%r12)
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x19a, %rax            # imm = 0x19A
               	jne	<addr>
               	xorq	%r15, %r15
               	movq	%r15, -0x60(%rbp)
               	jmp	<addr>
               	movl	$0x2, %r15d
               	movq	%r15, -0x60(%rbp)
               	jmp	<addr>
               	movq	-0x60(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
