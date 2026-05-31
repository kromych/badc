
double_pointers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xa, %r11d
               	movl	%r11d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r11
               	movq	(%r11), %r9
               	movl	$0x2a, %r11d
               	movl	%r11d, (%r9)
               	movslq	-0x8(%rbp), %r8
               	cmpq	$0x2a, %r8
               	je	0x4002f6 <.text+0x86>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	-0x10(%rbp), %r11
               	movslq	(%r11), %r8
               	cmpq	$0x2a, %r8
               	je	0x40032d <.text+0xbd>
               	movl	$0x2, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400537 <malloc>
               	movq	%rax, %r12
               	movl	$0x4, %r14d
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x400537 <malloc>
               	movq	%rax, (%r12)
               	movq	(%r12), %r14
               	movl	$0x7b, %eax
               	movl	%eax, (%r14)
               	movq	(%r12), %rdi
               	movslq	(%rdi), %rax
               	cmpq	$0x7b, %rax
               	je	0x400395 <.text+0x125>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	(%r12), %rdi
               	movslq	(%rdi), %r12
               	cmpq	$0x7b, %r12
               	je	0x4003cc <.text+0x15c>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
