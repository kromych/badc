
deferred_jit_thread_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002b2 <.text+0x42>
               	movq	%rax, %rdi
               	callq	*0xfe49(%rip)           # 0x4100d0
               	movslq	%edi, %r11
               	leaq	0xfe4f(%rip), %r9       # 0x4100e0
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movl	%r11d, (%rdi)
               	movq	%r11, %r8
               	shlq	$0x2, %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	(%r11), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %r9
               	movq	%fs:0x0, %r9
               	subq	$0x10, %r9
               	movslq	(%r9), %rbx
               	cmpq	$0x7, %rbx
               	je	0x400307 <.text+0x97>
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x8, %r9
               	movslq	(%r9), %rbx
               	cmpq	$-0x3, %rbx
               	je	0x40033f <.text+0xcf>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x10, %r9
               	movq	%fs:0x0, %rbx
               	subq	$0x10, %rbx
               	movslq	(%rbx), %r8
               	movq	%fs:0x0, %rbx
               	subq	$0x8, %rbx
               	movslq	(%rbx), %rdi
               	movq	%r8, %rbx
               	addq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	movl	%ebx, (%r9)
               	movq	%fs:0x0, %rdi
               	subq	$0x10, %rdi
               	movslq	(%rdi), %rbx
               	cmpq	$0x4, %rbx
               	je	0x4003b9 <.text+0x149>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
