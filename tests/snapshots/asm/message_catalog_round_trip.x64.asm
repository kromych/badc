
message_catalog_round_trip.x64:	file format elf64-x86-64

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
               	subq	$0x160, %rsp            # imm = 0x160
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x158(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	0x10(%rcx), %r10d
               	movl	%r10d, 0x10(%rax)
               	movzwq	0x14(%rcx), %r10
               	movw	%r10w, 0x14(%rax)
               	movzbq	0x16(%rcx), %r10
               	movb	%r10b, 0x16(%rax)
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x158(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x140(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x158(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x158(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x140(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	movl	$0xc0, %esi
               	leaq	<rip>, %rdx
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0x140(%rbp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0xc0(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x140(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x158(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	cmpq	$-0x1, %r12
               	jne	<addr>
               	movl	$0x5, %ebx
               	jmp	<addr>
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	leaq	<rip>, %rcx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %ebx
               	movl	$0x7, %esi
               	movl	$0x3, %edx
               	leaq	<rip>, %rcx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	movl	$0x1, %esi
               	movl	$0x9, %edx
               	leaq	<rip>, %rcx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %ebx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x9, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
