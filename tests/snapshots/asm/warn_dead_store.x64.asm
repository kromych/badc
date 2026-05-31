
warn_dead_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0x1, %eax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %r11d
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movslq	%r11d, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %r8d
               	movl	%r8d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %r11d
               	movl	$0x5, %r9d
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rbx
               	movl	$0x1, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	callq	<addr>
               	addq	%rax, %rbx
               	movslq	%ebx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
