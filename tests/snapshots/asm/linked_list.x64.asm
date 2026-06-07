
linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	xorq	%r12, %r12
               	movq	%r12, %rbx
               	movq	%r12, %r14
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	movq	%rcx, %r14
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ebx, %rax
               	movq	%rax, (%rcx)
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x0, %r14
               	je	<addr>
               	movslq	%r12d, %r12
               	movq	(%r14), %rax
               	addq	%rax, %r12
               	addq	$0x8, %r14
               	movq	(%r14), %r14
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
