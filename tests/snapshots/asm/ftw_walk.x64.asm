
ftw_walk.x64:	file format elf64-x86-64

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

<visit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	<rip>, %eax # <addr>
               	movl	<rip>, %ecx # <addr>
               	addq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x1, %edx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdx, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rdx
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	jmp	<addr>
               	leaq	0x64(%rdx), %rax
               	leave
               	retq

<stop_at_file>:
               	movl	$0x2a, %eax
               	xorl	%ecx, %ecx
               	testl	%edx, %edx
               	cmovneq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x268, %rsp            # imm = 0x268
               	pushq	%rbx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	xorl	%r8d, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x2, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x1c0, %esi            # imm = 0x1C0
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	$0x5, %ebx
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	xorl	%r8d, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x2, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	-<rip>, %rsi # <addr>
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
