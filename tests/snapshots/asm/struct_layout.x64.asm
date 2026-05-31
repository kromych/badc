
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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x3, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x3, %r11
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x28, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x29, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x2a, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x20, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x20, %r11
               	je	<addr>
               	movl	$0x2b, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x32, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x33, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x34, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x24, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x24, %r11
               	je	<addr>
               	movl	$0x35, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3c, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3d, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x3e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x3f, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	<addr>
               	movl	$0x40, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x46, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x47, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x48, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x5, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x5, %r11
               	je	<addr>
               	movl	$0x49, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x6, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x6, %r11
               	je	<addr>
               	movl	$0x4a, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xe, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xe, %r11
               	je	<addr>
               	movl	$0x4b, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	<addr>
               	movl	$0x4c, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x11, %r11
               	je	<addr>
               	movl	$0x4d, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x50, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x51, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x52, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1a, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1a, %r11
               	je	<addr>
               	movl	$0x53, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5a, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5b, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0x5c, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x6, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x6, %r11
               	je	<addr>
               	movl	$0x5d, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x5e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x10, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x10, %r11
               	je	<addr>
               	movl	$0x5f, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x12, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x12, %r11
               	je	<addr>
               	movl	$0x60, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x14, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x14, %r11
               	je	<addr>
               	movl	$0x61, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x64, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x65, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x66, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x67, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xc, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	<addr>
               	movl	$0x68, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x14, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x14, %r11
               	je	<addr>
               	movl	$0x69, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x16, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x16, %r11
               	je	<addr>
               	movl	$0x6a, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x18, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x18, %r11
               	je	<addr>
               	movl	$0x6b, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x6f, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x78, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x79, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x82, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x83, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x8c, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x8d, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x4, %r11
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x8, %r11
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x96, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x97, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x98, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x99, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x9, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x9, %r11
               	je	<addr>
               	movl	$0x9a, %eax
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xa0, %eax
               	retq
               	xorq	%r11, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xa1, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0xa2, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xa, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xa, %r11
               	je	<addr>
               	movl	$0xa3, %eax
               	retq
               	xorq	%r11, %r11
               	addq	$0xc, %r11
               	movslq	%r11d, %r11
               	cmpq	$0xc, %r11
               	je	<addr>
               	movl	$0xa4, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, 0x41(%rdx)
