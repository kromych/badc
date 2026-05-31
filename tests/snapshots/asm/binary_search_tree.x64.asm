
binary_search_tree.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40047c <.text+0x20c>
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
               	jne	0x400316 <.text+0xa6>
               	movl	$0x10, %edi
               	movslq	%edi, %rdi
               	addq	$0x8, %rdi
               	movslq	%edi, %r14
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
               	jge	0x400364 <.text+0xf4>
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, (%r15)
               	jmp	0x400342 <.text+0xd2>
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
               	jmp	0x400342 <.text+0xd2>
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
               	jne	0x4003da <.text+0x16a>
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
               	jne	0x40040d <.text+0x19d>
               	movl	$0x1, %edi
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
               	cmpq	%r8, %r12
               	jge	0x40044c <.text+0x1dc>
               	movq	%rbx, %r8
               	addq	$0x8, %r8
               	movq	(%r8), %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	0x400384 <.text+0x114>
               	addq	$0x10, %rbx
               	movq	(%rbx), %r15
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	0x400384 <.text+0x114>
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
               	callq	0x400384 <.text+0x114>
               	cmpq	$0x0, %rax
               	jne	0x400535 <.text+0x2c5>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
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
               	callq	0x400384 <.text+0x114>
               	cmpq	$0x0, %rax
               	jne	0x400579 <.text+0x309>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
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
               	callq	0x400384 <.text+0x114>
               	cmpq	$0x1, %rax
               	jne	0x4005bf <.text+0x34f>
               	movl	$0x3, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
