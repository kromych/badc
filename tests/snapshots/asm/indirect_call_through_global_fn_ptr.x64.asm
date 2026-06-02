
indirect_call_through_global_fn_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %r11
               	movl	$0x7, %r9d
               	movl	%r9d, (%r11)
               	leaq	<rip>, %r8
               	movl	$0x23, %r9d
               	movl	%r9d, (%r8)
               	leaq	<rip>, %rbx
               	movslq	(%r11), %rsi
               	movslq	(%r8), %rdx
               	leaq	<rip>, %r8
               	movq	(%r8), %r8
               	movq	%r8, %r11
               	movq	%rbx, %rdi
               	callq	*%r11
               	movslq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
