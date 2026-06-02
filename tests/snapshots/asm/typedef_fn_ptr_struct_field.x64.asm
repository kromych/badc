
typedef_fn_ptr_struct_field.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	imulq	%rsi, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %r11
               	leaq	-<rip>, %r9        # <addr>
               	movq	%r9, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x8, %r8
               	xorq	%r9, %r9
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %rbx
               	movq	(%rbx), %r9
               	movl	$0x3, %edi
               	movl	$0x7, %esi
               	movq	%r9, %r11
               	callq	*%r11
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rbx
               	movl	$0x4, %edi
               	movl	$0x5, %esi
               	movq	%rbx, %r11
               	callq	*%r11
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x9, %esi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %rbx
               	cmpq	$0x12, %rbx
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rbx
               	movq	(%rbx), %rbx
               	movl	$0x6, %edi
               	movl	$0x4, %esi
               	movq	%rbx, %r11
               	callq	*%r11
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
