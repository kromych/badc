
fcntl_lock_via_cast_fnptr.x64:	file format elf64-x86-64

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
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x60(%rbp), %rbx
               	movl	$0x40, %r12d
               	leaq	<rip>, %r13
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdi
               	movl	$0x42, %esi
               	movl	$0x1a4, %edx            # imm = 0x1A4
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x20(%rbp), %rdi
               	xorl	%r12d, %r12d
               	movl	$0x20, %edx
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x1, %r15d
               	movw	%r15w, (%rdx)
               	movw	%r12w, 0x2(%rdx)
               	movslq	%ebx, %rdi
               	movl	$0x6, %r12d
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x2, %eax
               	movw	%ax, (%rdx)
               	movslq	%ebx, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x20(%rbp), %rdx
               	movw	%r15w, (%rdx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	%ebx, %rdi
               	movq	%rax, %rcx
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	*%rcx
               	movq	%rax, %r12
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%r13d, %r13d
               	jne	<addr>
               	testl	%r14d, %r14d
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	testl	%r12d, %r12d
               	jne	<addr>
               	xorl	%eax, %eax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<__c5_sys_fcntl>:
               	jmp	<addr>
