
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
               	movq	%fs:0x0, %rdi
               	subq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rdi
               	subq	$0x8, %rdi
               	movl	$0x63, %eax
               	movl	%eax, (%rdi)
               	movq	%fs:0x0, %r8
               	subq	$0x8, %r8
               	movslq	(%r8), %r8
               	cmpq	$0x63, %r8
               	je	<addr>
               	movl	$0xbad2, %eax           # imm = 0xBAD2
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r8
               	subq	$0x8, %r8
               	movslq	(%r8), %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	xorq	%rbx, %rbx
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r15
               	leaq	-0x20(%rbp), %rdi
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%r14, %r11
               	movq	%rbx, %rsi
               	movq	%rbx, %rcx
               	callq	*%r11
               	movq	-0x20(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movq	%r15, %r11
               	callq	*%r11
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
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
               	addb	%al, 0x41(%rdx)
