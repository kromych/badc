
deferred_jit_thread_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002ac <.text+0x3c>
               	movq	%rax, %rdi
               	callq	*0xfe49(%rip)           # 0x4100d0
               	movslq	%edi, %r11
               	leaq	0xfe4f(%rip), %r9       # 0x4100e0
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movl	%r11d, (%rdi)
               	shlq	$0x2, %r11
               	addq	%r11, %r9
               	movslq	(%r9), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x400287 <.text+0x17>
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %rbx
               	cmpq	$0x7, %rbx
               	je	0x4002fe <.text+0x8e>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movslq	(%rbx), %rax
               	cmpq	$-0x3, %rax
               	je	0x400336 <.text+0xc6>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movq	%fs:0x0, %rbx
               	subq	$0x10, %rbx
               	movslq	(%rbx), %r8
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movslq	(%rbx), %rdi
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, (%rax)
               	movq	%fs:0x0, %rdi
               	subq	$0x10, %rdi
               	movslq	(%rdi), %r8
               	cmpq	$0x4, %r8
               	je	0x4003ad <.text+0x13d>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
