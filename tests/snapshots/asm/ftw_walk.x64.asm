
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdx, %rbx
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x1, %ebx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	<rip>, %rcx      # <addr>
               	movl	%eax, (%rcx)
               	cmpl	$0x1, %ebx
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	0x64(%rbx), %rax
               	popq	%rbx
               	leave
               	retq

<stop_at_file>:
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2a, %eax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<make_file>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	$-0x1, %rax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
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
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
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
               	leaq	<rip>, %rcx      # <addr>
               	xorl	%r8d, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x1, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x2, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx      # <addr>
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
               	leaq	<rip>, %rcx      # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x5, %ebx
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx      # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx      # <addr>
               	xorl	%r8d, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x1, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x2, %r8d
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x258(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
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
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-<rip>, %rsi      # <addr>
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
