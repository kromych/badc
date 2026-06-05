
struct_layout.x64:	file format elf64-x86-64

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
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5, %eax
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	retq
               	jmp	<addr>
               	movl	$0x7, %eax
               	retq
               	jmp	<addr>
               	movl	$0x8, %eax
               	retq
               	jmp	<addr>
               	movl	$0xa, %eax
               	retq
               	jmp	<addr>
               	movl	$0xb, %eax
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	retq
               	jmp	<addr>
               	movl	$0xd, %eax
               	retq
               	jmp	<addr>
               	movl	$0xe, %eax
               	retq
               	jmp	<addr>
               	movl	$0x14, %eax
               	retq
               	jmp	<addr>
               	movl	$0x15, %eax
               	retq
               	jmp	<addr>
               	movl	$0x16, %eax
               	retq
               	jmp	<addr>
               	movl	$0x17, %eax
               	retq
               	jmp	<addr>
               	movl	$0x1e, %eax
               	retq
               	jmp	<addr>
               	movl	$0x1f, %eax
               	retq
               	jmp	<addr>
               	movl	$0x20, %eax
               	retq
               	jmp	<addr>
               	movl	$0x21, %eax
               	retq
               	jmp	<addr>
               	movl	$0x28, %eax
               	retq
               	jmp	<addr>
               	movl	$0x29, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2a, %eax
               	retq
               	jmp	<addr>
               	movl	$0x2b, %eax
               	retq
               	jmp	<addr>
               	movl	$0x32, %eax
               	retq
               	jmp	<addr>
               	movl	$0x33, %eax
               	retq
               	jmp	<addr>
               	movl	$0x34, %eax
               	retq
               	jmp	<addr>
               	movl	$0x35, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3c, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3d, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3e, %eax
               	retq
               	jmp	<addr>
               	movl	$0x3f, %eax
               	retq
               	jmp	<addr>
               	movl	$0x40, %eax
               	retq
               	jmp	<addr>
               	movl	$0x46, %eax
               	retq
               	jmp	<addr>
               	movl	$0x47, %eax
               	retq
               	jmp	<addr>
               	movl	$0x48, %eax
               	retq
               	jmp	<addr>
               	movl	$0x49, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4a, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4b, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4c, %eax
               	retq
               	jmp	<addr>
               	movl	$0x4d, %eax
               	retq
               	jmp	<addr>
               	movl	$0x50, %eax
               	retq
               	jmp	<addr>
               	movl	$0x51, %eax
               	retq
               	jmp	<addr>
               	movl	$0x52, %eax
               	retq
               	jmp	<addr>
               	movl	$0x53, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5a, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5b, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5c, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5d, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5e, %eax
               	retq
               	jmp	<addr>
               	movl	$0x5f, %eax
               	retq
               	jmp	<addr>
               	movl	$0x60, %eax
               	retq
               	jmp	<addr>
               	movl	$0x61, %eax
               	retq
               	jmp	<addr>
               	movl	$0x64, %eax
               	retq
               	jmp	<addr>
               	movl	$0x65, %eax
               	retq
               	jmp	<addr>
               	movl	$0x66, %eax
               	retq
               	jmp	<addr>
               	movl	$0x67, %eax
               	retq
               	jmp	<addr>
               	movl	$0x68, %eax
               	retq
               	jmp	<addr>
               	movl	$0x69, %eax
               	retq
               	jmp	<addr>
               	movl	$0x6a, %eax
               	retq
               	jmp	<addr>
               	movl	$0x6b, %eax
               	retq
               	jmp	<addr>
               	movl	$0x6e, %eax
               	retq
               	jmp	<addr>
               	movl	$0x6f, %eax
               	retq
               	jmp	<addr>
               	movl	$0x78, %eax
               	retq
               	jmp	<addr>
               	movl	$0x79, %eax
               	retq
               	jmp	<addr>
               	movl	$0x82, %eax
               	retq
               	jmp	<addr>
               	movl	$0x83, %eax
               	retq
               	jmp	<addr>
               	movl	$0x8c, %eax
               	retq
               	jmp	<addr>
               	movl	$0x8d, %eax
               	retq
               	jmp	<addr>
               	movl	$0x8e, %eax
               	retq
               	jmp	<addr>
               	movl	$0x8f, %eax
               	retq
               	jmp	<addr>
               	movl	$0x96, %eax
               	retq
               	jmp	<addr>
               	movl	$0x97, %eax
               	retq
               	jmp	<addr>
               	movl	$0x98, %eax
               	retq
               	jmp	<addr>
               	movl	$0x99, %eax
               	retq
               	jmp	<addr>
               	movl	$0x9a, %eax
               	retq
               	jmp	<addr>
               	movl	$0xa0, %eax
               	retq
               	jmp	<addr>
               	movl	$0xa1, %eax
               	retq
               	jmp	<addr>
               	movl	$0xa2, %eax
               	retq
               	jmp	<addr>
               	movl	$0xa3, %eax
               	retq
               	jmp	<addr>
               	movl	$0xa4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
