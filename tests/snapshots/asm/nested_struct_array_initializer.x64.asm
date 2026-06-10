
nested_struct_array_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x64, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movslq	0x10(%rax), %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movslq	0x14(%rax), %rcx
               	cmpq	$0x5, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movslq	0x18(%rax), %rcx
               	cmpq	$0x6, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	movslq	0x1c(%rax), %rax
               	cmpq	$0xc8, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x28, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0x13, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
