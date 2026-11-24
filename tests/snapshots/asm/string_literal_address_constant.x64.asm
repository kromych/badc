
string_literal_address_constant.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0x1, %eax
               	movl	%eax, (%rsp)
               	movl	$0x0, 0x8(%rsp)
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x65, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x6c, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x6c, %ecx
               	je	<addr>
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x6f, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x65, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movzwq	(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rax
               	cmpl	$0x81, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x62, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x7a, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x79, %ecx
               	je	<addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rdx
               	cmpl	$0x7a, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movl	(%rdx), %edx
               	cmpl	$0x79, %edx
               	je	<addr>
               	xorl	%ecx, %ecx
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	jne	<addr>
               	movsbq	(%rcx), %rax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	(%rsp), %rcx
               	movl	(%rax,%rcx,4), %eax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rsp), %ecx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	0x8(%rsp), %rcx
               	movzwq	(%rax,%rcx,2), %rax
               	cmpl	$0x8000, %eax           # imm = 0x8000
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	0x8(%rsp), %rcx
               	movsbq	(%rax,%rcx), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
