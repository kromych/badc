
c99_qualifiers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002ba <.text+0x9a>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movq	%rsi, %r9
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r9, %r8
               	movq	%r11, %r9
               	addq	%r8, %r9
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r9, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%rsi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movq	%r8, -0x10(%rbp)
               	jmp	0x400276 <.text+0x56>
               	movq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jae	0x4002ad <.text+0x8d>
               	movslq	-0x8(%rbp), %r8
               	movslq	(%r11), %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	movq	-0x10(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movq	%rsi, -0x10(%rbp)
               	jmp	0x400276 <.text+0x56>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x7, %r11d
               	movl	%r11d, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rbx
               	movl	$0x1, %r12d
               	movl	$0x2, %r14d
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x3, %rax
               	je	0x400331 <.text+0x111>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r15d
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400255 <.text+0x35>
               	cmpq	$0x7, %rax
               	je	0x400376 <.text+0x156>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd6b(%rip), %r15      # 0x4100e8
               	movzbq	(%r15), %rax
               	movq	%rax, %r15
               	xorq	$0x62, %r15
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	je	0x4003c7 <.text+0x1a7>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	je	0x4003fe <.text+0x1de>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	je	0x400435 <.text+0x215>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	cmpq	$0x0, %r15
               	je	0x40046c <.text+0x24c>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc65(%rip), %r15      # 0x4100d8
               	movl	$0x1, %eax
               	movl	%eax, (%r15)
               	movl	(%r15), %ebx
               	movq	%rbx, %r15
               	xorq	$0x1, %r15
               	movl	$0xffffffff, %ebx       # imm = 0xFFFFFFFF
               	andq	%r15, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4004c4 <.text+0x2a4>
               	movl	$0x7, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
