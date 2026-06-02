
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
               	movq	%rdi, %r11
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	popq	%rbp
               	retq
               	movl	$0x63, %r9d
               	movl	%r9d, (%r11)
               	movslq	(%r11), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0xbad2, %r9d           # imm = 0xBAD2
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movslq	(%r11), %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%fs:0x0, %r10
               	subq	$0x8, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x1, %r9d
               	movq	0x28(%rsp), %r11
               	movl	%r9d, (%r11)
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
               	movq	%rax, %rbx
               	leaq	-0x20(%rbp), %rdi
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%r15, %r11
               	movq	%r12, %rsi
               	movq	%r12, %rcx
               	callq	*%r11
               	movq	-0x20(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movq	%rbx, %r11
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
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %r10
               	movslq	(%r10), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
