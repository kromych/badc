
sqlite_min.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x20(%rax), %r14
               	movq	0x28(%rax), %r15
               	leaq	<rip>, %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movq	%rcx, %rax
               	callq	*%rax
               	movslq	%eax, %rbx
               	testq	%rbx, %rbx
               	jge	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x400, %esi            # imm = 0x400
               	movq	%r15, %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xc8(%rbp), %rsi
               	movq	%r14, %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movl	$0x2, %esi
               	movl	$0x1, %edx
               	movq	%r13, %rcx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	*%rcx
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	movq	%rbx, %rdi
               	callq	*%rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq

<__c5_sys_open>:
               	jmp	<addr>

<__c5_sys_close>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<__c5_sys_ftruncate>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	movq	0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<__c5_sys_fcntl>:
               	jmp	<addr>

<__c5_sys_stat>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	movq	0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<__c5_sys_fstat>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x10(%rbp), %rdi
               	movq	0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
