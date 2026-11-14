
designator_completes_a_union.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	<rip>, %xmm1 # <addr>
               	movsd	<rip>, %xmm0
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movsd	-0x10(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	<rip>, %xmm0
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	movsd	-0x10(%rbp), %xmm1
               	ucomisd	%xmm0, %xmm1
               	movq	%rcx, %r10
               	cmovpq	%rax, %r10
               	cmoveq	%r10, %rax
               	imulq	$0x14, %rax, %rax
               	leave
               	retq
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x6, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
