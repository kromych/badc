
string_literal_no_room_for_nul.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movzbq	(%r11), %r9
               	movq	%r9, %r11
               	xorq	$0x65, %r11
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400268 <.text+0x48>
               	movl	$0x1, %eax
               	retq
               	leaq	0xfe61(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0xf, %rax
               	movzbq	(%rax), %r11
               	movq	%r11, %rax
               	xorq	$0x6b, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x4002a7 <.text+0x87>
               	movl	$0x2, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfe42(%rip), %rax      # 0x4100f0
               	movzbq	(%rax), %r11
               	movq	%r11, %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x4002dc <.text+0xbc>
               	movl	$0x3, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfe0d(%rip), %rax      # 0x4100f0
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movzbq	(%r11), %rax
               	movq	%rax, %r11
               	xorq	$0x6f, %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400316 <.text+0xf6>
               	movl	$0x4, %eax
               	retq
               	leaq	0xfdd3(%rip), %r11      # 0x4100f0
               	movq	%r11, %rax
               	addq	$0x5, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400346 <.text+0x126>
               	movl	$0x5, %eax
               	retq
               	leaq	0xfda3(%rip), %r11      # 0x4100f0
               	movq	%r11, %rax
               	addq	$0x13, %rax
               	movzbq	(%rax), %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400376 <.text+0x156>
               	movl	$0x6, %eax
               	retq
               	leaq	0xfd97(%rip), %r11      # 0x410114
               	movzbq	(%r11), %rax
               	movq	%rax, %r11
               	xorq	$0x77, %r11
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4003a6 <.text+0x186>
               	movl	$0x7, %eax
               	retq
               	leaq	0xfd67(%rip), %r11      # 0x410114
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %r11
               	movq	%r11, %rax
               	xorq	$0x64, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x4003e5 <.text+0x1c5>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd28(%rip), %rax      # 0x410114
               	movq	%rax, %r11
               	addq	$0x5, %r11
               	movzbq	(%r11), %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x40041a <.text+0x1fa>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
