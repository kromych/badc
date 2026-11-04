
string_literal_address_constant.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x0, -0x8(%rbp)
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
               	leave
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
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x6c, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
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
               	leave
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
               	leave
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
               	xorq	$0x81, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
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
               	leave
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
               	leave
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
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x79, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movsbq	(%rcx), %rcx
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
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	-0x10(%rbp), %rcx
               	movl	(%rax,%rcx,4), %eax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	-0x10(%rbp), %ecx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movl	(%rax,%rcx,4), %eax
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movslq	-0x8(%rbp), %rcx
               	movzwq	(%rax,%rcx,2), %rax
               	xorq	$0x8000, %rax           # imm = 0x8000
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movslq	-0x8(%rbp), %rcx
               	movsbq	(%rax,%rcx), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	jmp	<addr>
