
binary_search_tree.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40048c <.text+0x21c>
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
               	jne	0x40031c <.text+0xac>
               	movl	$0x10, %edi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	addq	$0x8, %r8
               	movslq	%r8d, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x400747 <malloc>
               	movq	%rax, %rdi
               	xorq	%r14, %r14
               	movq	%r12, (%rdi)
               	movq	%rdi, %rsi
               	addq	$0x8, %rsi
               	movq	%r14, (%rsi)
               	movq	%rdi, %rdx
               	addq	$0x10, %rdx
               	movq	%r14, (%rdx)
               	movq	%rdi, %rcx
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
               	jge	0x40036d <.text+0xfd>
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdx
               	movq	%rdx, (%r15)
               	jmp	0x40034b <.text+0xdb>
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
               	movq	%rax, %rdx
               	movq	%rdx, (%r15)
               	jmp	0x40034b <.text+0xdb>
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
               	jne	0x4003e6 <.text+0x176>
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
               	jne	0x40041a <.text+0x1aa>
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
               	jge	0x400459 <.text+0x1e9>
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
               	jmp	0x400390 <.text+0x120>
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
               	jmp	0x400390 <.text+0x120>
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
               	movq	%rax, %rbx
               	movl	$0x46, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %r15
               	movl	$0x14, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %r12
               	movl	$0x28, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400390 <.text+0x120>
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x400552 <.text+0x2e2>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x28, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400390 <.text+0x120>
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	jne	0x40059a <.text+0x32a>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x63, %ebx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	0x400390 <.text+0x120>
               	movq	%rax, %rdi
               	cmpq	$0x1, %rdi
               	jne	0x4005e1 <.text+0x371>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
