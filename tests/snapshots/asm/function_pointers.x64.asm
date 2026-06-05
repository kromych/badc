
function_pointers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0xa, %ebx
               	movl	$0x14, %esi
               	movq	%rax, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %r12
               	leaq	-<rip>, %rax       # <addr>
               	movl	$0x5, %esi
               	movq	%rax, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movslq	%r12d, %rcx
               	movslq	%eax, %rax
               	imulq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
