
float_pointer_basics.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002c7 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100e0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4, %r11d
               	movl	$0x8, %r9d
               	movslq	%r11d, %r8
               	cmpq	$0x4, %r8
               	je	0x400329 <.text+0x79>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%r9d, %r11
               	cmpq	$0x8, %r11
               	je	0x400361 <.text+0xb1>
               	movl	$0x2, %r11d
               	movq	%r11, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %ebx
               	movslq	%ebx, %r11
               	movq	%r11, %r9
               	shlq	$0x2, %r9
               	movslq	%r9d, %r12
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x400657 <malloc>
               	movq	%rax, %r14
               	movslq	%ebx, %r12
               	movq	%r12, %rbx
               	shlq	$0x3, %rbx
               	movslq	%ebx, %r15
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	0x400657 <malloc>
               	movq	%rax, %rbx
               	movl	$0x3f800000, %r15d      # imm = 0x3F800000
               	movl	%r15d, (%r14)
               	movq	%r14, %rdi
               	addq	$0x4, %rdi
               	movl	$0x40000000, %r15d      # imm = 0x40000000
               	movl	%r15d, (%rdi)
               	movabsq	$0x3ff0000000000000, %rsi # imm = 0x3FF0000000000000
               	movq	%rsi, (%rbx)
               	movq	%rbx, %r15
               	addq	$0x8, %r15
               	movabsq	$0x4000000000000000, %rsi # imm = 0x4000000000000000
               	movq	%rsi, (%r15)
               	movslq	(%r14), %rdi
               	cmpq	$0x3f800000, %rdi       # imm = 0x3F800000
               	je	0x400411 <.text+0x161>
               	movl	$0x3, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r14, %rsi
               	addq	$0x4, %rsi
               	movslq	(%rsi), %rdi
               	cmpq	$0x40000000, %rdi       # imm = 0x40000000
               	je	0x400452 <.text+0x1a2>
               	movl	$0x4, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rsi
               	movabsq	$0x3ff0000000000000, %r11 # imm = 0x3FF0000000000000
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	je	0x400492 <.text+0x1e2>
               	movl	$0x5, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rsi
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	movq	%rsi, %rdi
               	cmpq	%r11, %rsi
               	je	0x4004dc <.text+0x22c>
               	movl	$0x6, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r14, %rdi
               	xorl	%eax, %eax
               	callq	0x40065d <free>
               	movslq	%eax, %rax
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x40065d <free>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
