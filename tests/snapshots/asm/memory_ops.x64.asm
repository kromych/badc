
memory_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400307 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100e8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xa, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4005c7 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4005c7 <malloc>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x41, %r15d
               	movl	$0x9, %r14d
               	movq	%r15, %rsi
               	movq	%r14, %rdx
               	movq	0x20(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4005cd <memset>
               	movq	%rax, %rsi
               	movq	0x20(%rsp), %rsi
               	addq	$0x9, %rsi
               	xorq	%r12, %r12
               	movb	%r12b, (%rsi)
               	movq	%r15, %rsi
               	movq	%r14, %rdx
               	movq	0x28(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	0x4005cd <memset>
               	movq	%rax, %rdx
               	movq	0x28(%rsp), %rdx
               	addq	$0x9, %rdx
               	movb	%r12b, (%rdx)
               	movq	%rbx, %rdx
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	0x4005d3 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	je	0x4003f4 <.text+0x104>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movq	0x28(%rsp), %rbx
               	addq	$0x5, %rbx
               	movl	$0x42, %r14d
               	movb	%r14b, (%rbx)
               	movl	$0xa, %r15d
               	movq	%r15, %rdx
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	0x4005d3 <memcmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	cmpq	$0x0, %r14
               	jne	0x40045e <.text+0x16e>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
