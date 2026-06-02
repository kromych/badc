
function_type_typedef.x64:	file format elf64-x86-64

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
               	movq	%rdi, %r11
               	movslq	%esi, %rdi
               	movslq	%edx, %rsi
               	callq	*%r11
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %r11
               	movslq	%esi, %rdi
               	movslq	%edx, %rsi
               	callq	*%r11
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rbx       # <addr>
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0xa, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %esi
               	movl	$0x6, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0x14, %esi
               	movl	$0x8, %edx
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %edx
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
