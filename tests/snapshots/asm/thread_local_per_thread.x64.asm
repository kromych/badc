
thread_local_per_thread.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	popq	%rbp
               	retq
               	movl	$0x63, %ecx
               	movl	%ecx, (%rax)
               	movslq	(%rax), %rcx
               	cmpq	$0x63, %rcx
               	je	<addr>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	popq	%rbp
               	retq
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movl	$0x1, %eax
               	movl	%eax, (%rbx)
               	xorq	%r12, %r12
               	movl	$0x2, %esi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	<rip>, %rsi
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	-0x20(%rbp), %rdi
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%r15, %r11
               	movq	%r12, %rsi
               	movq	%r12, %rcx
               	callq	*%r11
               	movq	-0x20(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movq	%r14, %r11
               	callq	*%r11
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
