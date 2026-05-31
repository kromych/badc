
bst_free.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400467 <.text+0x1b7>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100e0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%rdi, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x400310 <.text+0x60>
               	xorq	%r8, %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %r12
               	movq	%r12, %rdi
               	callq	0x4002c7 <.text+0x17>
               	movq	%rbx, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r14
               	movq	%r14, %rdi
               	callq	0x4002c7 <.text+0x17>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400627 <free>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
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
               	jne	0x4003f9 <.text+0x149>
               	movl	$0x10, %edi
               	movslq	%edi, %rdi
               	movq	%rdi, %r8
               	addq	$0x8, %r8
               	movslq	%r8d, %r14
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40062d <malloc>
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
               	jge	0x400447 <.text+0x197>
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r14
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400367 <.text+0xb7>
               	movq	%rax, (%r15)
               	jmp	0x400425 <.text+0x175>
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
               	callq	0x400367 <.text+0xb7>
               	movq	%rax, (%r15)
               	jmp	0x400425 <.text+0x175>
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
               	callq	0x400367 <.text+0xb7>
               	movq	%rax, %r14
               	movl	$0x1e, %r15d
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400367 <.text+0xb7>
               	movl	$0x46, %r12d
               	movq	%r14, %rdi
               	movq	%r12, %rsi
               	callq	0x400367 <.text+0xb7>
               	movq	%r14, %rdi
               	callq	0x4002c7 <.text+0x17>
               	movq	%rbx, %rcx
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
