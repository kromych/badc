
indirect_call_ten_scalar_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<main>:
               	subq	$0x28, %rsp
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdi
               	leaq	0x3(%rax), %rdx
               	leaq	0x4(%rax), %r8
               	leaq	0x5(%rax), %r9
               	leaq	0x6(%rax), %r10
               	leaq	0x7(%rax), %rsi
               	leaq	0x8(%rax), %r11
               	movq	%r10, 0x10(%rsp)
               	leaq	0x9(%rax), %r10
               	movq	%r10, 0x18(%rsp)
               	shlq	%rcx
               	addq	%rcx, %rax
               	leaq	(%rdi,%rdi,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %r10
               	imulq	$0x7, %r10, %rcx
               	addq	%rcx, %rax
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	leaq	(%r11,%r11,8), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x181, %rax            # imm = 0x181
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
