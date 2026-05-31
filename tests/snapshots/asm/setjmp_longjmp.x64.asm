
setjmp_longjmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40030a <.text+0x6a>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100d0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	movq	%rbx, %r8
               	addq	$0x200, %r8             # imm = 0x200
               	movl	%r12d, (%r8)
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x4005e7 <longjmp>
               	movzbq	%al, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x250, %rsp            # imm = 0x250
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x400360 <.text+0xc0>
               	movl	$0xb, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	leaq	-0x208(%rbp), %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x4005ed <setjmp>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movslq	%r14d, %r12
               	cmpq	$0x0, %r12
               	jne	0x4003cc <.text+0x12c>
               	movslq	%ebx, %r12
               	leaq	-0x208(%rbp), %r15
               	movl	$0x7, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	0x4002b7 <.text+0x17>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movslq	%r14d, %r12
               	cmpq	$0x7, %r12
               	je	0x400404 <.text+0x164>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movslq	%ebx, %rax
               	cmpq	$0x1, %rax
               	je	0x40043b <.text+0x19b>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x208(%rbp), %r12
               	movq	%r12, %rax
               	addq	$0x200, %rax            # imm = 0x200
               	movslq	(%rax), %r12
               	cmpq	$0x7, %r12
               	je	0x400484 <.text+0x1e4>
               	movl	$0xf, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
