
signed_cast_extends.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<rtu>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0xff, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x80, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x80, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x7f, %edi
               	callq	<addr>
               	andq	$0xff, %rax
               	movsbq	%al, %rax
               	cmpl	$0x7f, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x12345678, %edi       # imm = 0x12345678
               	callq	<addr>
               	movsbq	%al, %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x1234abff, %edi       # imm = 0x1234ABFF
               	callq	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0xffff, %edi           # imm = 0xFFFF
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movswq	%ax, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movl	$0x8000, %edi           # imm = 0x8000
               	callq	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movswq	%ax, %rax
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x12345678, %edi       # imm = 0x12345678
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$0x5678, %eax           # imm = 0x5678
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x1234ffff, %edi       # imm = 0x1234FFFF
               	callq	<addr>
               	movswq	%ax, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movl	$0xffffffd6, %edi       # imm = 0xFFFFFFD6
               	callq	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x2a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	$0xff, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, 0x8(%rsp)
               	movl	$0x42, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	andq	$0xff, %r10
               	movq	%r10, (%rsp)
               	movl	$0x10, %edi
               	callq	<addr>
               	movq	0x8(%rsp), %rax
               	movsbq	%al, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	(%rsp), %rax
               	orq	$-0x100, %rax
               	cmpl	$0xffffff42, %eax       # imm = 0xFFFFFF42
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
