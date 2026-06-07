
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
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rbx
               	addq	$0x1, %rbx
               	movq	%rcx, %r12
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ebx, %rax
               	movl	%eax, (%rcx)
               	movq	%rcx, %rax
               	addq	$0x8, %rax
               	movq	%r12, (%rax)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %r12
               	je	<addr>
               	movslq	%ecx, %rcx
               	movslq	(%r12), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %r12
               	movq	(%r12), %r12
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
