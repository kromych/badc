
struct_fn_ptr_field_deref_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	retq
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	addq	$0x7, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rbx)
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movq	(%rbx), %rax
               	movl	$0xa, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %r12
               	movq	(%rbx), %rax
               	movl	$0x14, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	movslq	%r12d, %rcx
               	cmpq	$0xd, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rbx)
               	movq	(%rbx), %rax
               	movl	$0x64, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %r12
               	movq	(%rbx), %rax
               	movl	$0xc8, %edi
               	movq	%rax, %r11
               	callq	*%r11
               	movslq	%r12d, %rcx
               	cmpq	$0x6b, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movslq	%eax, %rax
               	cmpq	$0xcf, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
