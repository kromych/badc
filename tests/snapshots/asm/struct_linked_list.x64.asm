
struct_linked_list.x64:	file format elf64-x86-64

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
               	xorq	%rbx, %rbx
               	movl	%ebx, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rbx
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdx
               	movslq	-0x20(%rbp), %rax
               	movl	%eax, (%rdx)
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rbx
               	je	<addr>
               	movslq	%ecx, %rax
               	movslq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rbx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
