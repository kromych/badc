
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
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0xa, %esi
               	movl	$0x4, %edx
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0x5, %esi
               	movl	$0x6, %edx
               	callq	<addr>
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rdi       # <addr>
               	movl	$0x14, %esi
               	movl	$0x8, %edx
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
