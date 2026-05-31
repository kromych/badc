
struct_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400257 <.text+0x37>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfe54(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x1, %r9
               	je	0x4002b4 <.text+0x94>
               	movl	$0x1, %r9d
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfe15(%rip), %r11      # 0x4100d0
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rbx
               	movl	$0x2, %r12d
               	movl	$0x3, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	cmpq	$0x5, %rax
               	je	0x400314 <.text+0xf4>
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
               	leaq	0xfdb5(%rip), %r14      # 0x4100d0
               	movq	%r14, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %r15
               	movl	$0xa, %r14d
               	movl	$0x4, %ebx
               	movq	%r15, %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	callq	*%r11
               	cmpq	$0x6, %rax
               	je	0x400373 <.text+0x153>
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
               	leaq	0xfd56(%rip), %rbx      # 0x4100d0
               	movq	%rbx, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rbx
               	movzbq	(%rbx), %rax
               	movq	%rax, %rbx
               	xorq	$0x64, %rbx
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	$0x0, %rax
               	je	0x4003d1 <.text+0x1b1>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd20(%rip), %rbx      # 0x4100f8
               	movslq	(%rbx), %rax
               	cmpq	$0x2, %rax
               	je	0x40040f <.text+0x1ef>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfce2(%rip), %rbx      # 0x4100f8
               	movq	%rbx, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r12
               	movl	$0x7, %ebx
               	movl	$0x8, %r15d
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	cmpq	$0xf, %rax
               	je	0x40046e <.text+0x24e>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc83(%rip), %r15      # 0x4100f8
               	movq	%r15, %rax
               	addq	$0x18, %rax
               	movq	(%rax), %r15
               	movzbq	(%r15), %rax
               	movq	%rax, %r15
               	xorq	$0x61, %r15
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r15, %rax
               	cmpq	$0x0, %rax
               	je	0x4004cc <.text+0x2ac>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc4d(%rip), %r15      # 0x410120
               	movslq	(%r15), %rax
               	cmpq	$0x3, %rax
               	je	0x40050a <.text+0x2ea>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc0f(%rip), %r15      # 0x410120
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r14
               	movl	$0x1, %r15d
               	movq	%r14, %r11
               	movq	%r15, %rdi
               	movq	%r15, %rsi
               	callq	*%r11
               	cmpq	$0x2, %rax
               	je	0x400564 <.text+0x344>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbb5(%rip), %r15      # 0x410120
               	movq	%r15, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rbx
               	movl	$0x5, %r15d
               	movl	$0x1, %r12d
               	movq	%rbx, %r11
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	*%r11
               	cmpq	$0x4, %rax
               	je	0x4005c4 <.text+0x3a4>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb7d(%rip), %r12      # 0x410148
               	movslq	(%r12), %rax
               	cmpq	$0xa, %rax
               	je	0x400603 <.text+0x3e3>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb3e(%rip), %r12      # 0x410148
               	movq	%r12, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r12
               	cmpq	$0x14, %r12
               	je	0x40064c <.text+0x42c>
               	movl	$0xc, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfafd(%rip), %rax      # 0x410150
               	movslq	(%rax), %r12
               	cmpq	$0x1, %r12
               	je	0x40068b <.text+0x46b>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfabe(%rip), %rax      # 0x410150
               	movq	%rax, %r12
               	addq	$0x4, %r12
               	movslq	(%r12), %rax
               	cmpq	$0x2, %rax
               	je	0x4006d4 <.text+0x4b4>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
