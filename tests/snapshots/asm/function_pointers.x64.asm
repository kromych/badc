
function_pointers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	addq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	subq	%r9, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-<rip>, %r11       # <addr>
               	movl	$0xa, %ebx
               	movl	$0x14, %esi
               	movq	%rbx, %rdi
               	callq	*%r11
               	movq	%rax, %r12
               	leaq	-<rip>, %rsi       # <addr>
               	movl	$0x5, %r11d
               	movq	%rsi, %r10
               	movq	%rbx, %rdi
               	movq	%r11, %rsi
               	callq	*%r10
               	movslq	%r12d, %r12
               	movslq	%eax, %rax
               	imulq	%rax, %r12
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
