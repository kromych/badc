
binary_search_tree.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400483 <.text+0x213>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	cmpq	$0x0, %rbx
               	jne	0x400319 <.text+0xa9>
               	movl	$0x10, %edi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	addq	$0x8, %r8
               	movslq	%r8d, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x400727 <malloc>
               	xorq	%r14, %r14
               	movq	%r12, (%rax)
               	movq	%rax, %rsi
               	addq	$0x8, %rsi
               	movq	%r14, (%rsi)
               	movq	%rax, %rdx
               	addq	$0x10, %rdx
               	movq	%r14, (%rdx)
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rsi
               	cmpq	%rsi, %r12
               	jge	0x400367 <.text+0xf7>
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, (%r15)
               	jmp	0x400345 <.text+0xd5>
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %r15
               	addq	$0x10, %r15
               	movq	(%r15), %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, (%r15)
               	jmp	0x400345 <.text+0xd5>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	cmpq	$0x0, %rbx
               	jne	0x4003dd <.text+0x16d>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %r8
               	cmpq	%r12, %r8
               	jne	0x400411 <.text+0x1a1>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rdi
               	cmpq	%rdi, %r12
               	jge	0x400450 <.text+0x1e0>
               	movq	%rbx, %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	0x400387 <.text+0x117>
               	movq	%rbx, %r14
               	addq	$0x10, %r14
               	movq	(%r14), %r15
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	0x400387 <.text+0x117>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%rbx, %rbx
               	movl	$0x32, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %r14
               	movl	$0x1e, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400287 <.text+0x17>
               	movl	$0x46, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movl	$0x14, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400287 <.text+0x17>
               	movl	$0x28, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400387 <.text+0x117>
               	cmpq	$0x0, %rax
               	jne	0x40053b <.text+0x2cb>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x28, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400387 <.text+0x117>
               	cmpq	$0x0, %rax
               	jne	0x40057f <.text+0x30f>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400387 <.text+0x117>
               	cmpq	$0x1, %rax
               	jne	0x4005c4 <.text+0x354>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
